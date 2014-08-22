Preflight.Views.LinkedIn.ShareLink = function(el){
  this.handleShare = function(event){
    //success callbacks are not working at the moment
    //https://developer.linkedin.com/thread/2805
  }

  this.handleClick = function(e){
    if(IN){
      e.preventDefault();
      IN.UI.Share().params({
        url: this.$el.attr('data-share-url'),
        title: this.$el.attr('data-share-title'),
        summary: this.$el.attr('data-share-summary'),
        onsuccess: $.proxy(this.handleShare, this)
      }).place();
    }
  };

  this.$el = $(el);

  this.$el.on('click', $.proxy(this.handleClick, this));
}
