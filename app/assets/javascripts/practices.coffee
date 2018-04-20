# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(".modal-body").html("<%= j render('appointments/patient_request_form') %>").fadeIn(1500)
$("#doctor_ids").select2({val: "<%= '#{@selected_doctor_id}' %>"})
$("#status-options").select2({placeholder: "Select a type",})
$("#start_times").select2({placeholder: "Select a time",})

$('.select2-container').addClass('full-width')


consultation_time = "00:30"
reg_appointment_time = "01:00"


$("#appointment_date").on "change", ->
  if $('#doctor_ids').length
    doctor_id = $('#doctor_ids option:selected').val()
  else
    doctor_id = $('#doctor_id').val()
  response = $.ajax({
    type: "GET"
    url: "/days/check"
    data:{date: $("#appointment_date").val(), doctor_id: doctor_id}
    contentType: 'application/json'
    dataType: 'json'
    success: (data) ->
      setStartTimes(data)
    error: (xhr, status, response) ->
      alert(response)
  })
$("#doctor_ids").on "change", ->
  if $('#doctor_ids').length
    doctor_id = $('#doctor_ids option:selected').val()
  else
    doctor_id = $('#doctor_id').val()
  url = "/users/check_billing/" + doctor_id
  response2 = $.ajax({
    type: "GET",
    url: url,
    contentType: 'application/json',
    dataType: 'json',
    success: (data) ->
      setBillingRate(data)
    error: (xhr, status, response) ->
      alert(response)
  })

$('.appointmentRadio').on "change", ->
  toggleBilling(this)

setStartTimes = (json) ->
  $('#start_times').html('')
  $.each json, (index, element) ->
    select = document.getElementById("start_times")
    option = document.createElement("option")
    option.text = element
    option.value = index
    select.appendChild(option)
  $('#select2-chosen-3').html("")
  $('#select2-chosen-4').html("")
  $('#start_times').focusin()
  $('#start_times').focusout()
  $('#start_times').trigger("change")

setBillingRate = (json) ->
  rate = '$' +json+'.00'
  $('#billing-rate').html(rate)
  $('#billing-rate').data('rate', json)


toggleClasses = (class_to_hide, class_to_show) ->
  $(class_to_show).removeClass('hidden')
  if !$(class_to_hide).hasClass('hidden')
    $(class_to_hide).addClass('hidden')

toggleBilling = (input_object) ->
  if input_object.value == "Regular Appointment"
    toggleClasses('.consultation-button','.credit-card')
  else if input_object.value == "Consultation"
    toggleClasses('.credit-card', '.consultation-button')
