$(document).ready(function() {

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

	value_input_copy(qwe);

	var clipboard = new Clipboard('.copy');

	turn_on_parallax();

});
