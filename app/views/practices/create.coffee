$('.billing-alert').removeClass('hidden')
$('.billing-alert').addClass('alert').addClass('alert-success').html('You saved your Billing Portal')
swapAlerts = () ->
  $('.billing-alert').addClass('hidden')
  $('.billing-alert').removeClass('alert')
  $('.billing-alert').removeClass('alert-success')

setTimeout(swapAlerts, 3000)
