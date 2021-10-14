$("#new_contact_u").validate({
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

  	"contact_u[email]":{
  		required: true,
  		email: true
  	},
  	"contact_u[subject]" :{
  		required: true
  	},
  	"contact_u[name]" :{
  		required: true
  	}

  },

  messages:{
    "contact_u[email]":{
      required: "Email is required",
      email: "Please enter a valid email address"

    },
     "contact_u[subject]":{
      required: "Subject is required"
    },
    "contact_u[name]" :{
      required: "Full name is required"
    }
  }
  
});

