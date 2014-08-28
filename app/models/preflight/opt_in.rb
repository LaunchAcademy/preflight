module Preflight
  class OptIn
    attr_reader :subscriber, :subscription

    def initialize(params, campaign, request = nil, cookies = nil)
      @subscriber = Subscriber.find_or_initialize_by(email: params[:email])

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
          @subscription = @subscriber.subscribe_to!(@campaign, @referrer)
          if @cookies
            @cookies.delete(Preflight.referring_cookie_key)
            @cookies.signed[Preflight.subscription_cookie_key] =
              subscription_cookie_values(@subscription)
          end
        end
      end
    end

    protected
    def subscription_cookie_values(sub)
      {
        value: sub.id,
        expires: 45.days.from_now
      }
    end
  end
end
