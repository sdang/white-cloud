// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.hint.js
//= require jquery-ui.min.js
//= require jquery.idTabs.min.js
//= require common.js

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
	$(this).parent().slideUp("fast");
});

$(document).on('click', '#phi-explanation-link', function() {
	$('#phi-explanation').fadeToggle('fast');
})

