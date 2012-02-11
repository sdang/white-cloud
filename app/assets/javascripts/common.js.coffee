
$ ->
	$('input[title!=""]').hint();
	$(".reminder").find('div:first').fadeTo(0,0.5);
	$("#dashboard").click =>
		window.location = "/"
	$(".navigation-tab").click -> 
		window.location = $(this).find("a:first")[0].href
	$(".submit").mousedown -> 
		form = $(this).parents('form:first')
		form.submit()
		$(this).fadeTo(0.3,0.5)
	$(".submit").mouseup -> 
		$(this).fadeTo(0.3,1)
	$("input").keydown ->
		$(this).parents('form:first').submit() if event.keyCode == 13