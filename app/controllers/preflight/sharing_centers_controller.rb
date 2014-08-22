module Preflight
  class SharingCentersController < ApplicationController
    before_action :require_cookie!

    def show
      @subscription = remembered_subscription
    end

    protected
    def remembered_subscription
      @remembered_subscription ||= Preflight::CampaignSubscription.
        find(subscription_id)
    end

    def subscription_id
      @subscription_id ||= cookies.signed[Preflight.subscription_cookie_key]
    end

    def require_cookie!
      redirect_to root_path unless remembered_subscription.present?
    end
  end
end
