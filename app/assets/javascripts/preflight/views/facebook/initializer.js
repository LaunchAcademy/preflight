Preflight.Views.Facebook.Initializer = function(appId){
  window.fbAsyncInit = function() {
    FB.init({
      appId      : appId,
      xfbml      : true,
      cookie     : true,
      status     : true,
      version    : 'v2.0'
    });
  };

  (function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  $('body').append($('<div>').attr('id', 'fb-root'));
}
