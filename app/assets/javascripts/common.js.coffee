
$ ->
	# activate all place holders for legacy browsers
	$('input, textarea').placeholder();
	
	# fade edit / delete icons on all lists
	$(".reminder").find('div:first').fadeTo(0,0.5);
	
	# toggle visibility of change password fields
	$('#hide-show-change-password').click =>
		$('#change-password').slideToggle('fast')
	
	# toggle visibility of dc summary preview
	$('#show-hide-dc-summary').click ->
		$('#dc-summary-content').slideToggle('fast')
		if $('#show-hide-dc-summary').html() == "Show Preview"
			$('#show-hide-dc-summary').html("Hide Preview")
		else
			$('#show-hide-dc-summary').html("Show Preview")
		end
		
	# toggle visibility of patient instructions preview
	$('#show-hide-patient-instructions').click ->
		$('#patient-instructions-content').slideToggle('fast')
		if $('#show-hide-patient-instructions').html() == "Show Preview"
			$('#show-hide-patient-instructions').html("Hide Preview")
		else
			$('#show-hide-patient-instructions').html("Show Preview")
		end
		
	# side bar save dc summary button
	$(document).on('click','#save-discharge-summary', ->
		$('.edit_dc_summary').submit())
		
	# side bar finalize dc summary button
	$('#finalize-discharge-summary').click ->
		ans = confirm("Finalize this discharge? This will prevent any further editing!")
		if ans
			$('#finalize-discharge-summary').html("Please Wait ...")
			$('#dc_summary_finalized').val("t")
			$('.edit_dc_summary').attr("data-remote", "false")
			$('.edit_dc_summary').submit()
		end
		
	# toggle visibility of phi explanation
	$('#phi-explanation-link').click ->
		$('#phi-explanation').toggle('fast');