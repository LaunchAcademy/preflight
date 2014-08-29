require 'omniauth/builder'
require 'omniauth-crew-check'
require 'slugged'
require 'simple_form'
require 'kaminari'

require 'preflight/responder'
require 'preflight/receiving_controller'

OmniAuth.config.path_prefix = '/preflight/auth'

module Preflight
  class Engine < ::Rails::Engine
    isolate_namespace Preflight

    config.autoload_paths << "#{config.root}/app/view_objects"
    config.assets.paths << config.root.join('vendor', 'assets', 'components')

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

    initializer "precompile zero clipboard" do |app|
      app.config.assets.precompile += %w(ZeroClipboard.swf)
    end
  end
end
