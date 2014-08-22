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

      cookie_val = cookies ? cookies[Preflight.referring_cookie_key] : nil
      if cookie_val
        @referrer = Preflight::CampaignSubscription.where(id: cookie_val).first
      end
      @campaign = campaign
    end

    def save
      @subscriber.save.tap do |res|
        if res && @campaign.present?
          @subscription = @subscriber.subscribe_to!(@campaign, @referrer)
        end
      end
    end
  end
end
