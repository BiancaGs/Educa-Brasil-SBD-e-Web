$(document).ready(function() {

    // Muda a opacidade da flecha ao descer a página
    $(window).scroll(function(){
        $(".arrow").css("opacity", 1 - $(window).scrollTop() / 500);
    });

    // Desce a página ao clicar na flecha de scroll
    $('.btn-scroll').click(function() {
        $('html, body').animate({
            scrollTop: $("#sobre").offset().top - 60
        }, 1500);
    });

});