$("#new_user").validate({
  //error place
    errorPlacement: function (error, element) {
    error.insertAfter(element).css('color','red');
      // $(element).css('background', '#ffdddd');
      // $(element).css('color', 'white');

  },

//adding rule
  rules: {
  // username is required with max of 20 and min of 6
  "user[profile_picture]":{
    required: true,
  },
   "user[username]":{
    required: true,
  },
    "user[description]":{
    required: true,
  },
  // email is required with format
  "user[email]": {
    required: true,
    email: true
  },
  // password is required
  "user[password]": {
    required: true
  },
  // password_confirmation is required and is the same with password
  "user[password_confirmation]": {
    required: true,
    equalTo: "#user_password"
  }

},


  // error messages
  messages: {
     "user[profile_picture]":{
      required: "profile picture is required.",
    },
    "user[username]":{
      required: "Username is required.",
    },
    "user[email]":{
      required: "Email is required",
      email: "Please enter a valid email address"
    },
     "user[description]":{
      required: "Description is required",
    },
   "user[password]": {
      required: "Password is required"
    },
    "user[password_confirmation]": {
      required: "Password confirmation is required",
      equalTo: "password and confirm password not matched"
    }
  }
});

