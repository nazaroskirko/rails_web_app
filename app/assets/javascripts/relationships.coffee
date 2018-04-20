# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".search").on "click", ->
  $.ajax({type: "Get",url: "/search/users",data:{user_email: $('#search').val()}});
  $('.patient-search').removeClass('active');
  $('.restore-button').addClass('active');

$(".restore-button").on "click", ->
  $(".restore-button").removeClass('active');
  $('.patient-search').addClass('active');
  $('.patient-info').addClass('waiting');
  $('.confirm-relationship').removeClass('active');
  $('.reconfirm-relationship').removeClass('active');
  $('#email-success').removeClass('active');
  $('#email-failure').removeClass('active');

$(".start-relationship").on "click", ->
  $('#new_relationship').submit();

$('.reconfirm-relationship-btn').on "click", ->
    $.ajax({type: "Get", url: "/relationships/reconfirm", data:{patient_id: $('#relationship_patient_id').val(), doctor_id: $('#relationship_doctor_id').val() }})
$('.confirm-relationship-btn').on "click", ->
    $.ajax({type: "Get", url: "/relationships/confirm", data:{patient_id: $('#relationship_patient_id').val(), doctor_id: $('#relationship_doctor_id').val() }})


$("#start_times").select2({minimumResultsForSearch: -1});
$("#end_times").select2({minimumResultsForSearch: -1});
$("#day_day_num").select2({minimumResultsForSearch: -1});
$("#day_date").addClass('full-width');
# email = $("#search").val();
