$ ->
	$('input[title!=""]').hint();
	$(".reminder").find('div:first').fadeTo(0,0.5);
	$("#dashboard").click =>
		window.location = "/"
	$(".navigation-tab").click -> 
		window.location = $(this).find("a:first")[0].href
