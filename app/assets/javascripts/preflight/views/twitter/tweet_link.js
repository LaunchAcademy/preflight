Preflight.Views.Twitter.TweetLink = function(el){
  this.$el = $(el);

  if(twttr) {
    if(!Preflight.tweetListener){
      Preflight.tweetListener = new Preflight.Views.Twitter.TweetListener();
    }
  }
}
