require 'omniauth/builder'
require 'omniauth-crew-check'

OmniAuth.config.path_prefix = '/preflight/auth'

module Preflight
  class Engine < ::Rails::Engine
    isolate_namespace Preflight

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
  end
end
