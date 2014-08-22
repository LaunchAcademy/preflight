Preflight.Views.Twitter.TweetListener = function(){
  this.ready = function(twttr){
    twttr.events.bind('tweet', $.proxy(this.handleTweet, this));
  };

  //event.data is not populated, so if we want more data, we'll have to
  //retrieve it via oauth or via the streaming api
  this.handleTweet = function(event){
  }

  twttr.ready($.proxy(this.ready, this));
}
