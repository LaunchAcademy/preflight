Preflight.Views.Campaigns.Form = function(el){
  this.$el = $(el);

  new Preflight.Components.TimePicker($('#campaign_started_at_date',
    this.$el));

  new Preflight.Components.TimePicker($('#campaign_ended_at_date',
    this.$el));
};
