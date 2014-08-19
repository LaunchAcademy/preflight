module Preflight
  module Admin
    class CampaignsController < AdminController
      respond_to :html

      def new
        @campaign = Campaign.new
      end

      def create
        @campaign = Campaign.new(campaign_params)
        @campaign.save
        respond_with(@campaign, location: admin_campaigns_path)
      end

      def index
        @campaigns = Campaign.page(params[:page])
      end

      def show
        @campaign = Campaign.find_using_slug!(params[:id])
      end

      protected
      def campaign_params
        params.require(:campaign).permit(:title, :description, :ended_at_date,
          :started_at_date)
      end
    end
  end
end
