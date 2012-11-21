document.addEventListener 'readystatechange', ->
  make_the_dumb_in_dumb_receipt_red()
  add_copyright_class_to_final_paragraph()

add_copyright_class_to_final_paragraph = ->
  paragraphs = document.getElementsByTagName 'p'
  paragraphs[paragraphs.length-1].className = 'copyright'

make_the_dumb_in_dumb_receipt_red = ->
  h1 = document.getElementsByTagName('h1')[0]
  h1.innerHTML = h1.innerHTML.replace /Dumb/, '<span class="sr_red">Dumb</span>'
