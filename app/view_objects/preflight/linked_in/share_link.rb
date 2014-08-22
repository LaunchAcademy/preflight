module Preflight
  module LinkedIn
    class ShareLink
      include Preflight::ViewObject

    # this will send a redirect back with a post_id param
      def initialize(text, url, title, description, options = {})
        @text = text
        @url = url
        @title = title
        @description = description
        @options = options
      end

      def html
        link_to @text, share_url, {
          'target' => '_blank',
          'data-share-url' => @url,
          'data-share-title' => @title,
          'data-share-summary' => @description
        }.merge(@options)
      end

      protected
      def share_url
        "http://www.linkedin.com/shareArticle?" +
        {
          mini: true,
          url: @url,
          title: @title,
          summary: @description
        }.to_query
      end
    end
  end
end
