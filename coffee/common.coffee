$(document).on 'keydown change', '.form-control', ->
  if $(this).val() != ''
    $(this).addClass 'form-control-filled'
  else
    $(this).removeClass 'form-control-filled'