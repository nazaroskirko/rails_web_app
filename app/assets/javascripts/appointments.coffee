# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(window).load ->
  $(".new-patient").on "click", ->
      $.ajax({type: "Get",url: "/relationships/new"});

  $(".new-appointment").on "click", ->
      $.ajax({type: "Get",url: "/appointments/new",data:{patient_id: $(this).data('uid')}});

  $(".new-doctor-request").on "click", ->
      $.ajax({type: "Get",url: "/appointments/new",data:{doctor_id: $(this).data('uid')}});

  $("#appointment_start").on "focusout", ->
      start = $('#appointment_start').val().split(':')
      endHours = parseInt(start[0]) + 1
      if endHours < 10
        endHours = "0" + endHours.toString()
      else
        endHours = endHours.toString()
      time_string = endHours + ':' + start[1]
      $('#appointment_end').val(time_string)

  tabl = $('#appointments_table');
  settings = {
    "sDom": "<'table-responsive't><'row'<p i>>",
    "sPaginationType": "bootstrap",
    "destroy": true,
    "scrollCollapse": true,
    "oLanguage": {
      "sLengthMenu": "_MENU_ ",
      "sInfo": "Showing <b>_START_ to _END_</b> of _TOTAL_ entries"
    },
    "iDisplayLength": 5
  };

  tabl.dataTable();
  $('#appointments_table-table').on "live", ->
    tabl.fnFilter($(this).val())


  $('button').filter ->
    return this.className.match(/.*new-.*/)
  .removeClass('hidden')
  return