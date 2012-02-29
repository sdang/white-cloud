$(document).ready(function () {
  var top = $('#followContent').offset().top - parseFloat($('#followContent').css('marginTop').replace(/auto/, 0));
	$(".alert").alert();

  $(window).scroll(function (event) {
    // what the y position of the scroll is
    var y = $(this).scrollTop();
  
    // whether that's below the form
    if (y >= top) {
      // if so, ad the fixed class
      $('#followContent').addClass('fixed');
    } else {
      // otherwise remove it
      $('#followContent').removeClass('fixed');
    }
  });
});