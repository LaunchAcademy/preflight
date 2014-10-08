module Preflight
  module ReceivingController
    extend ActiveSupport::Concern

    included do
      before_action :receive_referral
    end

    protected
    def current_subscription
      if !@current_subscription
        subscription_id = cookies.signed[Preflight.subscription_cookie_key]
        if subscription_id.present?
          @current_subscription = Preflight::CampaignSubscription.find_by(
            id: subscription_id
          )
        end
      end

      @current_subscription
    end

    def receive_referral
      if !referring_subscription.nil?
        cookies.signed[Preflight.referring_cookie_key] = referral_cookie_values
        return true
      end

      return false
    end

    def referring_subscription
      if ref_param
        @referring_subscription ||= Preflight::CampaignSubscription.where({
          invitation_token: ref_param
        }).first
      else
        nil
      end
    end

    def ref_param
      params[Preflight.param_key]
    end

    def referral_cookie_values
      {
        value: referring_subscription.id,
        expires: 45.days.from_now
      }
    end
  end
end
