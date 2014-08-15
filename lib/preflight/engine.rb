require 'omniauth/builder'
require 'omniauth-crew-check'
require 'slugged'
require 'simple_form'

require 'preflight/responder'

OmniAuth.config.path_prefix = '/preflight/auth'

module Preflight
  class Engine < ::Rails::Engine
    isolate_namespace Preflight

    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.assets false
      g.helper false
    end

    initializer 'omniauth' do |app|
      app.middleware.use OmniAuth::Builder do
        provider :crew_check,
          Preflight.configuration.github_key,
          Preflight.configuration.github_secret_key,
          :role_map => ->{{
            'admin' => Preflight.configuration.admin_teams
          }},
          :role_required => false,
          :scope => ['user']
      end
    end

    initializer 'better_date_picker' do
      require 'better_date_picker'
    end
  end
end
