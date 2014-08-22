Preflight.Views.Facebook.ShareLink = function(el){
  this.$el = $(el);

  this.shareUrl = function(){
    //if we're behind NAT or on localhost, FB can't fetch opengraph metadata
    //which will cause an error
    if(Preflight.inDevelopment()){
      return 'http://www.google.com';
    }
    else {
      return this.$el.attr('data-share-url');
    }
  }
  
  this.handleClick = function(e){
    e.preventDefault();
    FB.ui({
      method: 'share',
      display: 'popup',
      href: this.shareUrl()
    }, function(response){

    })
  }

  this.$el.on('click', $.proxy(this.handleClick, this));
}
