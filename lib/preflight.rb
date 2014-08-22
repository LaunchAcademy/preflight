require 'preflight/configuration'

if defined?(Rails)
  require 'preflight/engine'
end

module Preflight
  @@configuration = Preflight::Configuration.new

  def self.configuration
    @@configuration
  end

  def self.configuration=(configuration)
    @@configuration = configuration
  end

  def self.configure(&block)
    @@configuration.update(&block)
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
