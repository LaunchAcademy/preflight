Preflight.Views.LinkedIn.Initializer = function(){
  var scriptTag = $('<script>').attr({
    'src': 'http://platform.linkedin.com/in.js'
  });

  scriptTag.html("api_key: " + Preflight.linkedInApiKey);
  $('body').append(scriptTag)
}
