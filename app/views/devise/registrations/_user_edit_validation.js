$("#edit_user").validate({
  //error place
  errorPlacement: function (error, element) {
  	error.insertAfter(element).css('color','red');
      // $(element).css('background', '#ffdddd');
      // $(element).css('color', 'white');

  },

  rules: {

  	"user[email]":{
  		required: true,
  		email: true
    },

    	"user[username]":{
  		required: true,
  	
    },
    	"user[display_name]":{
  		required: true,
  	
    },
   
    "user[current_password]":{
    	required: true
    }
  

  },

  messages :{

  	"user[email]":{
  		required: "Email is required",
      email: "Please enter a valid email address"

  	},
  	"user[username]":{
  		required: "username is required"
  	},
  		"user[display_name]":{
 		required: "Full name is required"  	
    },
    "user[current_password]":{
    	required: "Password is required"
    }
  }
  
});

