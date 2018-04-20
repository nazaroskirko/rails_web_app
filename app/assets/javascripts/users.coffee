# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require wizard/form_wizard.js
#= require wizard/scripts.js


(($) ->
  $('#form-register').validate()
) jQuery

$(".us-phone").mask("(999) 999-9999");
$(".zip").mask("99999")
edited = false
$('#general input').on "focusout", ->
  unless edited then $('.profile-submit').addClass('active')
  edited = true
c_edited = false
$('#complaint input').on "change", ->
  unless c_edited then $('.complaints-submit').addClass('active')
  c_edited = true

$('.country-codes').on "change", ->
  $('input[name="country"]' ).val($('select#Country option:selected').val())

$('#appointment_setting_billing_rate').on 'change', ->
  $('#appointment_setting_billing_rate').val(parseInt($('#appointment_setting_billing_rate').val()).toFixed(2));

$("#day_start").select2({minimumResultsForSearch: -1});
$("#day_end").select2({minimumResultsForSearch: -1});
$("#day_day_num").select2({minimumResultsForSearch: -1});
$("#day_date").addClass('full-width');
