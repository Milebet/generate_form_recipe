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
//= require jquery.validate
//= require jquery.validate.localization/messages_es
//= require date_wrapper
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

function validateDoctorProfileFunction() {
	$("#edit_doctor").validate({
		debug: false,
		rules: {
		"doctor[document]": { minlength: 10, maxlength: 13 },
		"doctor[first_name]": { minlength: 2 },
		"doctor[second_name]": { minlength: 2 },
		"doctor[last_name]": { minlength: 2 },
		"doctor[second_last_name]": { minlength: 2 },
		"doctor[married_name]": { minlength: 2 },
		"doctor[cell_phone]": { minlength: 10, maxlength: 13 },
		"doctor[local_phone]": { minlength: 7, maxlength: 9 },
	} 
	})
  }
$(document).ready(validateDoctorProfileFunction);
$(document).on('page:load', validateDoctorProfileFunction);

function validateRecipeFunction() {
	$("#new_recipe").validate({
		debug: false,
		rules: {
		"recipe[document]": { minlength: 10, maxlength: 13 },
		"recipe[full_name]": { minlength: 2 },
		"recipe[cell_phone]": { minlength: 10, maxlength: 13 },
		"recipe[local_phone]": { minlength: 7, maxlength: 9 },

	} 
	})
  }
$(document).ready(validateRecipeFunction);
$(document).on('page:load', validateRecipeFunction);