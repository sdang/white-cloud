// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui.min.js
//= require jquery.placeholder.min.js
//= require jquery.timeago.js
//= require jquery.livequery.js
//= require common.js
//= require bootstrap.min.js

if($.browser.msie && $.browser.version=="6.0") {
	window.location = "/unsupported_browser.html"
}

$(document).on('click', '#add-button', function() {
	$('#add-form').slideToggle('fast');
});

$(document).on('mouseenter','.reminder', function() {
	$(this).find('#links').fadeTo('fast', 1);
});

$(document).on('mouseleave','.reminder', function() {
	$(this).find('#links').fadeTo('fast',0.5);
});

$(document).on('click', '#fade', function() {
	$(this).parent().slideToggle("fast");
});

// handle session time-in-out

function logOut() {
	request = $.ajax({
	  type: "DELETE",
	  url: "/users/sign_out",
	  data: ""
	}).done();
	
	request.done(function(msg) {
		window.location.reload();
	});

	request.fail(function(jqXHR, textStatus) {
		window.location.reload();
	});
}

function displayTimeoutMsg() {
    $('#auto-logout').html("You will be logged out in 5 minutes, <a href='/user_logged_in' data-remote='true'>click here</a> to continue working");
	$('#auto-logout').effect("highlight", {}, 3000);
	doTimeout = setTimeout(logOut, 300000)
}

displayTimeout = setTimeout(displayTimeoutMsg, 1500000);