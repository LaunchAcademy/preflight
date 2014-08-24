module Preflight
  class SharesController < ApplicationController
    respond_to :json
    before_action :require_campaign_subscription!

    def create
      @share = Share.new(share_params) do |share|
        share.campaign_subscription = campaign_subscription
      end
      @share.save
      respond_with(@share) do |format|
        format.json { render json: @share }
      end
    end

    protected
    def share_params
      params.require(:share).permit(:provider, :uid)
    end

    def require_campaign_subscription!
      if campaign_subscription.nil?
        render json: {}, status: 422
        return false
      end
    end

    def campaign_subscription
      @campaign_subscription ||= Preflight::CampaignSubscription.find(sub_id)
    end

    def sub_id
      cookies.signed[Preflight.subscription_cookie_key]
    end
  end
end
