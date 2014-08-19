module Preflight
  class AdminController < ApplicationController
    layout 'preflight/admin'
    before_action :require_admin!

    protected
    def require_admin!
      roles = session[:preflight_roles]
      if !roles.kind_of?(Array) || !roles.include?('admin')
        redirect_to root_path, alert: 'Access Denied'
        return false
      end
    end
  end
end
