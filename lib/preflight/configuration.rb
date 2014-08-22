module Preflight
  class Configuration
    attr_accessor :github_key
    attr_accessor :github_secret_key
    attr_accessor :facebook_app_id
    attr_accessor :twitter_handle
    attr_accessor :admin_teams

    def initialize(&block)
      self.admin_teams = []
      update(&block) if block_given?
    end

    def update(&block)
      block.call(self)
    end
  end
end
