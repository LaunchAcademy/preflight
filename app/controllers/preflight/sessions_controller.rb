module Preflight
  class SessionsController < Preflight::ApplicationController
    def create
      if env['omniauth.auth'] && env['omniauth.auth']['extra']
        session[:preflight_roles] = env['omniauth.auth']['extra']['roles']
        flash[:notice] = 'You are now signed in.'
      end

      redirect_to preflight.root_path
    end
  end
end
