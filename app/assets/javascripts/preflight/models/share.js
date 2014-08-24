Preflight.Models.Share = function(attributes){
  this.attributes = attributes || {};

  this.saveSuccessful = function(data){
    this.attributes.id = data.id;
  };

  this.saveFailed = function(){
  };

  this.isPersisted = function(){
    return this.attributes.id ? true : false;
  };

  this.save = function(){
    $.ajax({
      url: Preflight.rootPath + "shares.json",
      method: 'POST',
      data: {
        share: this.attributes
      },
      context: this,
      success: $.proxy(this.saveSuccessful, this),
      error: $.proxy(this.saveFailed, this)
    });
  };
};
