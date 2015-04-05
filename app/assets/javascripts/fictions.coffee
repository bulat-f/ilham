$(document).ready( ->
  modal = ->
    $('#cover').attr 'style', "background-image: url(#{$(this).data('cover')})"
    $('#title').text $(this).data('title')
    $('#author').text $(this).data('author')
    $('#price').text $(this).data('price')
    $('#modal').modal('show')
    return

  $('.buy').click(modal)
)
