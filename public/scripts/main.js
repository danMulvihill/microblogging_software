$(document).ready(function(){

  //mobile menu

    $(".mobile-menu_open").on("click", function(e){
      e.preventDefault();
      $(".top-nav ul").slideDown();
      $(".mobile-menu_open").hide();
      $(".mobile-menu_close").show();

    })

    $(".mobile-menu_close").on("click", function(e){
      e.preventDefault();
      $(".top-nav ul").slideUp();
      $(".mobile-menu_close").hide();
      $(".mobile-menu_open").show();

    })

    //suppose to slide up the menu when user scrolls or clicks on container on mobile devices, but it's a little uncooperative

    if(innerWidth<=600){
      $(".container").on("click", function(){
          $(".top-nav ul").slideUp();
          $(".mobile-menu_close").hide();
          $(".mobile-menu_open").show();    
      })

      $(window).scroll(function(){
        $(".top-nav ul").slideUp();
        $(".mobile-menu_close").hide();
        $(".mobile-menu_open").show();
      })
    }

  //scroll back to top 

    $(".js-top").on("click", function(e){
      e.preventDefault();
      scroll(0);
    });

    function scroll(y){
      $('html,body').animate({
        scrollTop: y
       },500)
    }

//header appears on nav bar on scroll.

    $(window).on("scroll", function(){
      $(".top-nav h2 span").fadeIn();
      $("h1").fadeOut();
      //$(".sub h1").fadeOut();
    })


}); //end document.ready

