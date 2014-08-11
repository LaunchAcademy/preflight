require 'preflight/engine'
require 'preflight/configuration'

module Preflight
  @@configuration = Preflight::Configuration.new
  mattr_accessor :configuration

  def self.configure(&block)
    configuration.update(&block)
  end
end
