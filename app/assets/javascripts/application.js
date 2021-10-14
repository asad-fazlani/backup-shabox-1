//= require jquery.min.js
//= require bootstrap.min.js
//= require bootstrap-sprockets
//= require sticky/sticky.js
//= require social-share-button
//= require slick.js
//= require sweetalert
//= require aos.js
//= require npm.js
//= require owl.carousel.min.js
//= require rails-ujs
//= require jquery-ui
//= require jquery.inview.min.js
//= require autocomplete-rails
//= require select2
//= require cocoon
//= require jquery.raty
//= require ratyrate
//= require turbolinks
//= require toastr
//= require intlTelInput
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require_tree .

$(document).ready(function(){ 
    $(window).scroll(function(){ 
        if ($(this).scrollTop() > 100) { 
            $('#scroll').fadeIn(); 
        } else { 
            $('#scroll').fadeOut(); 
        } 
    }); 
    $('#scroll').click(function(){ 
        $("html, body").animate({ scrollTop: 0 }, 600); 
        return false; 
    }); 
    $(document).on('click', '.toggle-window', function(e) {
        e.preventDefault();
        var panel = $(this).parent().parent();
        var messages_list = panel.find('.messages-list');

        panel.find('.panel-body').toggle();
        panel.attr('class', 'panel panel-default');

        if (panel.find('.panel-body').is(':visible')) {
          var height = messages_list[0].scrollHeight;
          messages_list.scrollTop(height);
      }
  });
});

