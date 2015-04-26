init = ->
  return if typeof window.pluso.start is 'function' if window.pluso
  if window.ifpluso is `undefined`
    window.ifpluso = 1
    d = document
    s = d.createElement('script')
    g = 'getElementsByTagName'
    s.type = 'text/javascript'
    s.charset = 'UTF-8'
    s.async = true
    s.src = ((if 'https:' is window.location.protocol then 'https' else 'http')) + '://share.pluso.ru/pluso-like.js'
    h = d[g]('body')[0]
    h.appendChild s
  return

$(document).on 'page:receive', ->
  window.pluso = null
  window.ifpluso = `undefined`
  return

$(document).ready(init)
$(document).on('page:load', init)
