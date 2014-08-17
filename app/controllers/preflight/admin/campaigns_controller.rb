module Preflight
  module Admin
    class CampaignsController < ApplicationController
      respond_to :html
      layout 'preflight/admin'
      before_filter :require_admin!

      def new
        @campaign = Campaign.new
      end

      def create
        @campaign = Campaign.new(campaign_params)
        @campaign.save
        respond_with(@campaign, location: admin_campaigns_path)
      end

      def index
      end

      protected
      def campaign_params
        params.require(:campaign).permit(:title, :description, :ended_at_date,
          :started_at_date)
      end

      def require_admin!
        roles = session[:preflight_roles]
        if !roles.kind_of?(Array) || !roles.include?('admin')
          redirect_to root_path, alert: 'Access Denied'
          return false
        end
      end
    end
  end
end
