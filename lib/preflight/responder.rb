require 'responders'
module Preflight
  class Responder < ActionController::Responder
    include Responders::FlashResponder
    include Responders::HttpCacheResponder
  end
end
