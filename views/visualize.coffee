#
# helpers
#

Object.prototype.is_string = ->
  typeof @ == 'string' or @ instanceof String

Object.prototype.is_uuid = ->
  @is_string() and @match /[\da-f]{8}-[\da-f]{4}-[\da-f]{4}-[\da-f]{4}-[\da-f]{12}/

Object.prototype.is_array = ->
  @ instanceof Array

class Card
  constructor: (data)->
    @node = $('<dl class="visualize card dl-horizontal">')

    # FIXME DRY :alpha:
    for own key, value of data
      if value.is_uuid() and value != data.uuid
        @node.append (new Thumbnail value).node
      else if value.is_array()
          dt = $("<dt>#{key}</dt>")
          dl = $('<dl>')
          dd = $("<dd>&nbsp;</dd>")
          @node.append dt
          @node.append dd
          dd.append dl
          for item in value
            if item.constructor == Object
              for own k, v of item
                dl.append $("<dt>#{k}</dt>")
                dl.append $("<dd>#{v or '&nbsp;'}</dd>")
            else if item.is_uuid()
              dl.append (new Thumbnail item).node
            else
              dl.append $("<dd>#{item}</dd>")
      else
        @node.append $("<dt>#{key}</dt>")
        @node.append $("<dd>#{value or '&nbsp;'}</dd>")

class Thumbnail extends Card
  constructor: (uuid)->
    @uuid = uuid
    @node = $('<dl class="visualize thumbnail dl-horizontal">')
    @subject = $page.find_subject_by_uuid uuid

    # FIXME DRY :alpha:
    for own key, value of @subject
      unless value.is_uuid()
        @node.append $("<dt>#{key}</dt>")
        @node.append $("<dd>#{value or '&nbsp;'}</dd>")
      if value.is_array()
        console.log value


class VisualizationPage
  constructor: ->
    @set_up_messaging()
    @get_data()
    @cache_pointers()

  set_up_messaging: ->
    @window = $(window)

    @window.bind 'pointers_cached', =>
      @pointers_cached = true
      @try_to_render()

    @window.bind 'data_cached', =>
      @data_cached = true
      @try_to_render()

  try_to_render: ->
    @render() if @pointers_cached and @data_cached

  get_data: ->
    $.getJSON '/sync', (data)=>
      @data = data
      @window.trigger 'data_cached'

  cache_pointers: ->
    $ =>
      @visualize = $('#visualize')
      @window.trigger 'pointers_cached'

  render: ->
    @adjust_layout()
    for receipt in @data.receipts
      @add_card_for receipt

  adjust_layout: ->
    $('body').addClass 'visualize'

  add_card_for: (data)->
    @visualize.append (new Card data).node

  find_subject_by_uuid: (uuid)->
    for own key, value of @data
      if value.is_array()
        for subject in value
          if subject.uuid == uuid
            return subject if subject.uuid == uuid

$page = new VisualizationPage
