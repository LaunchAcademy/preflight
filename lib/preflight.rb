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

  def self.cookie_key
    :p_referring_id
  end
end
