// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require bootstrap-sprockets
//= require jquery.slimscroll.min.js
//= require skdslider.min.js
//= require adminlte.js
//= require cocoon
//= require_tree .

$(document).ready(function(){
	noticeTimeout();
  	errorTimeout();
	// carrousel slider
	jQuery('#demo1').skdslider(
		{'delay':3000, 
		'animationSpeed': 2000,
		'showNextPrev':true,
		'showPlayButton':true,
		'autoSlide':true,
		'animationType':'fading'}
	);
	jQuery('#responsive').change(function(){
		  $('#responsive_wrapper').width(jQuery(this).val());
	});

});


function noticeTimeout(){
  setTimeout(function(){
     $(".flash_notice").slideUp("slow")
  }, 2000);
}

function errorTimeout() {
  setTimeout(function(){
     $(".flash_error").slideUp("slow")
  }, 2000);
}
