# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->

	$('#comment_content_type').on 'change', ->
		$("#new_comment .collapse").collapse("hide")
		
		
	$("#new_comment .collapse").on 'hidden.bs.collapse', ->
		$(".custom-note").hide()
		$(".soap-note").hide()
		$(".dap-note").hide()
		$("#new_comment textarea").removeAttr('required')

		value = $('#comment_content_type').val()
		$(".comment-submit").removeClass('disabled');
		if  value == 'Custom Note'
			$(".custom-note").show()
			$(".custom-note textarea").attr('required', 'true')
		else if value == 'SOAP Note'
			$(".soap-note").show()
			$(".soap-note textarea").attr('required', 'true')
		else if value == 'DAP Note'
			$(".dap-note").show()
			$(".dap-note textarea").attr('required', 'true')
		else
			$(".comment-submit").addClass('disabled');
		$("#new_comment .collapse").collapse("show")