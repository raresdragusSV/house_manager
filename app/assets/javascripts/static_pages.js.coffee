# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.fields').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.fields').hide()
    event.preventDefault()

  $('#expenditure_to_all').click ->
    $('#forall').toggle()
    $('.destroy').val('false')
    $('.destroy').closest('.fields').show()
