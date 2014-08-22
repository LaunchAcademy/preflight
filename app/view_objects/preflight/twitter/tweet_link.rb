module Preflight
  module Twitter
    class TweetLink
      include Preflight::ViewObject

      def initialize(text, url, options)
        @text = text
        @url = url
        @options = options
      end

      def html
        link_to @text, share_url, {
          'data-share-url' => @url
        }.merge(@options)
      end

      protected
      def share_url
        'https://twitter.com/intent/tweet?' + {
          url: @url,
          via: Preflight.configuration.twitter_handle
        }.to_query
      end
    end
  end
end
