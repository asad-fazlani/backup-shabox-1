$("#new_blog").validate({
  //error place
    errorPlacement: function (error, element) {
    error.insertAfter(element).css('color','red');
      // $(element).css('background', '#ffdddd');
      // $(element).css('color', 'white');

  },

//adding rule
  rules: {
  // username is required with max of 20 and min of 6
  "blog[image]":{
    required: true,
  },
   "blog[title]":{
    required: true,
  },
    "blog[category_id]":{
    required: true,
  },
  // "blog[tag_ids][]": {
  //   required: true,
  // },
  // "blog[content]": {
  //   required: true
  // },

},


  // error messages
  messages: {
     "blog[image]":{
      required: "Blog image is required.",
    },
    "blog[title]":{
      required: "Bog title is required.",
    },
    // "blog[tag_ids][]":{
    //   required: "Blog tags is required",
    // },
     "blog[category_id]":{
      required: "Blog category is required",
    },
   // "blog[content]": {
   //    required: "Blog content is required"
   //  },
  }
});
