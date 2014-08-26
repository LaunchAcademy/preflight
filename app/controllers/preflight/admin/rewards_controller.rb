module Preflight
  module Admin
    class RewardsController < AdminController
      respond_to :html

      def new
        campaign
        @reward = campaign.rewards.new
      end

      def create
        @reward = campaign.rewards.build
        @reward.attributes = reward_params
        @reward.threshold_type = 'campaign_subscription'
        @reward.save
        respond_with(@reward, location: admin_campaign_path(campaign))
      end

      protected
      def campaign
        @campaign ||= Preflight::Campaign.find_using_slug!(params[:campaign_id])
      end

      def reward_params
        params.require(:reward).permit(:title, :description, :threshold_units,
          :rank)
      end
    end
  end
end
