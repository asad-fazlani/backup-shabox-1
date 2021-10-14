
$("#new_user").validate({
  rules: {
  "user[email]": {
    required: true,
    email: true
  },
  "user[password]": {
    required: true
  },

  },

  errorPlacement: function (error, element) {
    error.insertAfter(element).css('color','red');
      // $(element).css('background', '#ffdddd');
      // $(element).css('color', 'white');

  },
  messages: {
 
    "user[email]":{
      required: "Email is required",
      email: "Please enter a valid email address"
    },
    "user[password]": {
      required: "Password is required"
  
  }
}
});