#
# setup
#
$window = $(window) # cache it

$window.bind 'pointers_cached', =>
  @pointers_cached = true
  try_to_render()

$window.bind 'data_cached', =>
  @data_cached = true
  try_to_render()

$.getJSON '/sync', (data)=>
  @data = data
  $window.trigger 'data_cached'

$ ->
  cache_pointers()

#
# definitions
#

try_to_render = ->
  render_all() if @pointers_cached and @data_cached

render_all = ->
  console.log @data
  # render_sync()
  # render_receipts()
  # render_offers()
  # render_locations()
  # render_user()

cache_pointers = =>
  @sync_data      = $('#sync_data')
  @receipts_data  = $('#receipts_data')
  @offers_data    = $('#offers_data')
  @locations_data = $('#locations_data')
  @user_data      = $('#user_data')
  $window.trigger 'pointers_cached'
