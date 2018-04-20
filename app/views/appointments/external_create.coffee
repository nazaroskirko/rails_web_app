clearFlash = (alert_type) ->
  $('.alert').removeClass(alert_type)
  $('.flash-container').addClass('hidden')

externalAppointmentProcessed = (response) ->
  $('.flash-container').removeClass('hidden')
  msg = if response then 'Your appointment has been created' else 'Your appoinment was unsuccessfully create, please try again'
  $('.alert').html(msg)
  alert_type = if response then 'alert-success' else 'alert-danger'
  $('.alert').addClass(alert_type)
  setTimeout(clearFlash, 4000)

externalAppointmentProcessed("<%=@response%>")
