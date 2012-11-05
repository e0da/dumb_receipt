document.addEventListener 'readystatechange', ->
  document.getElementsByTagName('h1')[0].innerHTML = '<span class="sr_red">Dumb</span>Receipt'
  paragraphs = document.getElementsByTagName 'p'
  paragraphs[paragraphs.length-1].className = 'copyright'
