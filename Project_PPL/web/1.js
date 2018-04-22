 $(function () {
    //logo animation
    new WOW().init();
    //scroll header
    $(window).on('scroll', function () {
        var scrollTop = $(window).scrollTop();
        if (scrollTop > 50) {
            $('.navbar-fixed-top').stop().animate({height: "60px"}, 200);
            $('.navbar-nav > li > .dropdown-menu').css("margin-top", "-2px");
        } else {
            $('.navbar-fixed-top').stop().animate({height: "74px"}, 200);
            $('.navbar-nav > li > .dropdown-menu').css("margin-top", "12px");
        }
    });
})
 