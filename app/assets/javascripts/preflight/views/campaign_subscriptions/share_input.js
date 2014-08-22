Preflight.Views.CampaignSubscriptions.ShareInput = function(el){
  this.$el = $(el);

  var client = new ZeroClipboard($('a', this.$el));
  client.on('copy', function (event) {
    var clipboard = event.clipboardData;
    clipboard.setData( "text/plain", $('input', this.$el).val());
  });
}
