module Preflight
  class ApplicationController < ActionController::Base
    self.responder = Preflight::Responder
    include Preflight::ReceivingController
  end
end
