module Preflight
  class Configuration
    attr_accessor :github_key
    attr_accessor :github_secret_key
    attr_accessor :facebook_app_id
    attr_accessor :twitter_handle
    attr_accessor :linked_in_api_key
    attr_accessor :admin_teams
    attr_accessor :post_subscription_url
    
    attr_reader :subscription_listeners

    def initialize(&block)
      self.admin_teams = []
      @subscription_listeners = []
      update(&block) if block_given?
    end

    def update(&block)
      block.call(self)
    end

    def add_subscription_listener(the_proc)
      @subscription_listeners << the_proc
    end
  end
end
