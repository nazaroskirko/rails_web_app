$(document).ready(function() {

//============ Navmenu ============//

$('.top-nav:not(.no-local-scroll) li.scroll').localScroll();

$('.top-nav').mobileMenu({
	defaultText: 'Navigation',
	className: 'select-menu',
	subMenuDash: '&ndash;'
});

//============ Flexslider ============//

$('#main-slider').flexslider({
    animation: "fade",
    slideshowSpeed: 3500
});

$('.flexslider').flexslider({
    animation: "slide",
    controlNav: "thumbnails"
});

$('.top-nav').onePageNav({filter: ':not(.offpage)'});

//============ Fixed header ============//

$(window).scroll( function() {
    var value = $(this).scrollTop();
    if ( value > 350 ) {
        $(".top-nav .scroll").css("padding", "22px 15px 23px");
				$(".top-nav .blank").css("padding", "22px 15px 0px");
				$(".top-wrap").addClass("box");}
    else{
        $(".top-nav li").css("padding", "20px 15px");
				$(".top-wrap").removeClass("box");}

});

$(window).scroll( function() {
    var value = $(this).scrollTop();
    if ( value > 350 )
        $(".logo h1").css("margin", "0px 0 0 0");
    else
        $(".logo h1").css("margin", "10px 0 0 0");
});


});
