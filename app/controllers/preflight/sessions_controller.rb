module Preflight
  class SessionsController < Preflight::ApplicationController
    def create
      if env['omniauth.auth']
        session[:roles] = env['omniauth.auth']['extra']['roles']
        redirect_to preflight.root_path
      end
    end
  end
end
