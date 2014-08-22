module Preflight
  module Facebook
    class ShareLink
      include Preflight::ViewObject

      # this will send a redirect back with a post_id param
      def initialize(text, url, redirect_url, options = {})
        @text = text
        @url = url
        @redirect_url = redirect_url
        @options = options
      end

      def html
        link_to @text, share_url, {
          'target' => '_blank',
          'data-share-url' => @url
        }.merge(@options)
      end

      protected
      def share_url
        "https://www.facebook.com/dialog/feed?" +
        {
          app_id: Preflight.configuration.facebook_app_id,
          display: 'popup',
          link: @url,
          redirect_uri: @redirect_url
        }.to_query
      end
    end
  end
end
