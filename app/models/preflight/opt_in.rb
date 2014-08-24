module Preflight
  class OptIn
    attr_reader :subscriber, :subscription

    def initialize(params, campaign, request = nil, cookies = nil)
      if params[:email].present?
        @subscriber = Subscriber.find_or_initialize_by(email: params[:email])
      end

      if request
        @subscriber.ip_address = request.remote_ip
      end

      @cookies = cookies
      cookie_val = cookies ? cookies.signed[Preflight.referring_cookie_key] : nil
      if cookie_val
        @referrer = Preflight::CampaignSubscription.where(id: cookie_val).first
      end
      @campaign = campaign
    end

    def save
      @subscriber.save.tap do |res|
        if res && @campaign.present?
          if @cookies
            @cookies.delete(Preflight.referring_cookie_key)
          end
          @subscription = @subscriber.subscribe_to!(@campaign, @referrer)
        end
      end
    end
  end
end
