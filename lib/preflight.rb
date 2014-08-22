require 'preflight/engine'
require 'preflight/configuration'

module Preflight
  @@configuration = Preflight::Configuration.new
  mattr_accessor :configuration

  def self.configure(&block)
    configuration.update(&block)
  end

  def self.param_key
    :ref
  end

  def self.referring_cookie_key
    :p_referring_id
  end

  def self.subscription_cookie_key
    :p_subscription_id
  end

end
