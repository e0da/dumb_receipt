PRETTY_HTML = '<span class="sr_red">Dumb</span>Receipt'

document.addEventListener 'readystatechange', ->
  main()

make_dumb_receipt_h1_pretty = ->
  document.getElementsByTagName('h1')[0].innerHTML = PRETTY_HTML

main = ->
  make_dumb_receipt_h1_pretty()
