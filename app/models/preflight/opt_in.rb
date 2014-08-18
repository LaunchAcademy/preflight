module Preflight
  class OptIn
    attr_reader :subscriber

    def initialize(params, campaign, request = nil)
      if params[:email].present?
        @subscriber = Subscriber.find_or_initialize_by(email: params[:email])
      end

      if request.present?
        @subscriber.ip_address = request.remote_ip
      end

      @campaign = campaign

    end

    def save
      @subscriber.save.tap do |res|
        if res && @campaign.present?
          @subscriber.subscribe_to!(@campaign)
        end
      end
    end
  end
end
