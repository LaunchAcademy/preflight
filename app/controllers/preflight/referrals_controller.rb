module Preflight
  class ReferralsController < ApplicationController
    def show
      receive_referral
      if referring_subscription
        respond_to do |format|
          new_path = new_campaign_subscriber_path(referring_subscription.campaign)
          format.html do
            redirect_to new_path
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to root_path }
        end
      end
    end

    protected
    def referring_subscription
      @referring_subscription ||= Preflight::CampaignSubscription.where({
        invitation_token: params[:id]
      }).first
    end
  end
end
