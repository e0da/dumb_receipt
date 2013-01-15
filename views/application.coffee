document.addEventListener 'readystatechange', ->
  fix_up_header()

fix_up_header = ->
  @header = document.getElementsByTagName('h1')[0]
  make_the_dumb_in_dumb_receipt_red()
  make_header_link_back_to_home()

make_the_dumb_in_dumb_receipt_red = ->
  @header.innerHTML = @header.innerHTML.replace /Dumb/, '<span class="sr_red">Dumb</span>'

make_header_link_back_to_home = ->
  @header.addEventListener 'click', ->
    location.href = '/'
