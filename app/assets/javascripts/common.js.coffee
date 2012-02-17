
$ ->
	$('input[title!=""]').hint();
	$('textarea[title!=""]').hint();
	$(".reminder").find('div:first').fadeTo(0,0.5);
	$("#dashboard").click =>
		window.location = "/"
	$(".navigation-tab").click -> 
		window.location = $(this).find("a:first")[0].href
	$('#hide-show-change-password').click =>
		$('#change-password').slideToggle('fast')
	$('#show-hide-dc-summary').click ->
		$('#dc-summary-content').slideToggle('fast')
		if $('#show-hide-dc-summary').html() == "show"
			$('#show-hide-dc-summary').html("hide")
		else
			$('#show-hide-dc-summary').html("show")
		end
	$('#show-hide-patient-instructions').click ->
		$('#patient-instructions-content').slideToggle('fast')
		if $('#show-hide-patient-instructions').html() == "show"
			$('#show-hide-patient-instructions').html("hide")
		else
			$('#show-hide-patient-instructions').html("show")
		end