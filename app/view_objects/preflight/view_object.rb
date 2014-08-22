module Preflight
  module ViewObject
    extend ActiveSupport::Concern

    included do
      include ActionView::Helpers
      include Preflight::Engine.routes.url_helpers
    end
  end
end
