Preflight.Components.TimePicker = function(el){
  this.$el = $(el);

  this.dateWidgetChanged = function(dp, $input){
    this.$el.val($input.val());
  }

  //build icon that proceeds the input
  var $link = $('<a>').html('<i class="fa fa-calendar"></i>').
    attr('href', '#');

  this.$el.parent('div').addClass('large-12 row collapse');
  var $span = $('<span>').addClass('postfix').html($link)

  var $div = $('<div>').addClass('small-2 columns').html($span);
  var $wrapDiv = $('<div>').addClass('small-10 columns');

  $(this.$el).wrap($wrapDiv);
  var $parent = $($(this.$el).parent());
  $parent.after($div);

  //build the dropdown that responds to the icon click
  var dropdownId = 'dropdown-' + this.$el.attr('id');

  this.$triggerLink = $('a', $(this.$el).parents('div.row').first());

  $calInput = $('<input>').attr('type', 'text');

  var $dropdownDiv = $('<div>').attr({
    'id': dropdownId,
    'class': 'f-dropdown medium',
    'data-dropdown-content': 'data-dropdown-content'
  }).
  html($calInput);

  $parent.after($dropdownDiv);

  $('input', $('#' + dropdownId)).datetimepicker({
    inline: true,
    format: 'm/d/Y H:i',
    onChangeDateTime: $.proxy(this.dateWidgetChanged, this)
  });

  this.$triggerLink.attr({
    'data-dropdown': dropdownId
  });

  $(document).foundation();
}
