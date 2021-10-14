$("#new_blog_suggestion").validate({
  //error place
  errorPlacement: function (error, element) {
  	error.insertAfter(element).css('color','red');
      // $(element).css('background', '#ffdddd');
      // $(element).css('color', 'white');

  },

  rules: {

  	// "contact_u[mobile_number]": {
  	// 	required: true,
  	// },

  	"blog_suggestion[title]":{
  		required: true,
    }
  
  },

  messages :{
    "blog_suggestion[title]":{
      required: "title is required"
    }

  }
  
});

