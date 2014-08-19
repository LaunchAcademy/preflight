module Preflight
  class AdminsController < AdminController
    respond_to :html
    layout 'preflight/admin'

    before_action :require_admin!
  end
end
