// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.flexslider.js
//= require contact.js
//= require jquery.localscroll-1.2.7-min.js
//= require jquery.mobilemenu.js
//= require jquery.scrollTo.js
//= require jquery.nav.js
//= require main.js
//= require todo_lists


$(".pricing-tab").on('mouseenter', function () {
    if ($(this).hasClass('current-pricing')) {
    } else  {
      $('.pricing-tab').toggleClass('current-pricing');
      //var x = document.getElementById($(this));
      $('.pricing-table').toggleClass('current-table');

    }
});

$('#appointment_setting_billing_rate').on('change'), function() {
  $('#appointment_setting_billing_rate').val(parseInt($('#appointment_setting_billing_rate').val()).toFixed(2));
}
