# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

scroll = ->
  $("a.scrollto").click ->
    elementClick = $(this).attr("href")
    destination = $(elementClick).offset().top
    jQuery("html:not(:animated),body:not(:animated)").animate
      scrollTop: destination
    , 800
    false

  return

$(document).ready(scroll)
$(document).on('page:load', scroll)
