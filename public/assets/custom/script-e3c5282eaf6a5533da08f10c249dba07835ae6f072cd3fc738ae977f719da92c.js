$(document).ready(function() {

	var country = 0;
	var bg_country = 0;

	$('header .button').hover(function() {
		$('.ball_header').addClass('ball_header_hovered');
	}, function() {
		$('.ball_header').removeClass('ball_header_hovered');
	});

	function value_input_copy(url){
		var value_copy = url;
		value_copy = value_copy.replace('https://', '');
		$('#clip_input').attr('value', value_copy);
	}

	function show_popup(){
		$('.choose_country').fadeIn(400);
	}

	function get_country(elem){
		country = $(elem).attr('href');
		bg_country = $(elem).find('img').attr('src');
	}

	function set_country(){
		$('.country.active_label').css('background-image', 'url(' + bg_country + ')');
		$('.country_checkbox.active_label').attr('value', country);
	}

	function validate_input(){
		var valide_input = true;
		$('.create_s').find('input').each(function() {
			if($(this).val() == ''){
				valide_input = false;
			}
		});
		return valide_input;
	}

	function error_message(){
		$('.error_message').fadeIn(400);
		var hide_error = setTimeout(function(){
			$('.error_message').fadeOut(400);
		}, 5000);
	}

	var qwe = 'https://site.com/abcd';


	$('header .button').click(function(e) {
		e.preventDefault();
		var href = $(this).attr('href');
		$('.ball_header').addClass('ball_header_kicked');
		var timeout = setTimeout(function(){
			location.href = href;
		}, 500);
	});

	$('.slogan_slider').slick({
		dots: false,
		slidesToShow: 3,
	  	slidesToScroll: 1,
	  	responsive: [
	      {
	      breakpoint: 1025,
	      settings: {
	        slidesToShow: 2
	      	}
	  	  },
	  	  {
	  	  breakpoint: 769,
	  	  settings: {
		    slidesToShow: 1
		    }
	  	  }
	    ]
	});

	function turn_on_parallax(){
		var scene = $('#parallax').get(0);
		var sceneq = document.getElementById('bg_parallax');
		if($(window).width() >=1024){
			var parallaxInstance = new Parallax(scene, {});

			var parallaxInstance = new Parallax(sceneq, {});
		}
	}

	$('.country_checkbox').click(function(e){
		e.preventDefault();
		show_popup();
		$('.country_checkbox').removeClass('active_label');
		$('.country').removeClass('active_label');
		$(this).addClass('active_label');
		$(this).next('.country').addClass('active_label');
	});

	$('.country_item a').click(function(e){
		e.preventDefault();
		get_country($(this));
		set_country();
		$('.country_checkbox').removeClass('active_label');
		$('.country').removeClass('active_label');
		$('.choose_country').fadeOut(400);
	});

	$('.create_s').submit(function(e) {
		var valide = validate_input();
		if(valide != false && $('.create_s input[type="checkbox"]').prop("checked") != false){
			
		}else{
			error_message();
			e.preventDefault();
		}
	});

	value_input_copy(qwe);

	var clipboard = new Clipboard('.copy');

	turn_on_parallax();

});
