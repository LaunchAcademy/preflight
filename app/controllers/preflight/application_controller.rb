module Preflight
  class ApplicationController < ActionController::Base
    self.responder = Preflight::Responder
  end
end
