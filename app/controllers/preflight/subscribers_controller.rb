module Preflight
  class SubscribersController < ApplicationController
    respond_to :html

    def new
      @subscriber = Subscriber.new
    end

    def create
      @subscriber = Subscriber.new(subscriber_params) do |sub|
        sub.ip_address = request.remote_ip
      end
      
      if campaign.present?
        @subscriber.subscriptions.build do |s|
          s.campaign = campaign
        end
      end

      @subscriber.save
      respond_with(@subscriber, location: root_path)
    end

    protected
    def subscriber_params
      params.require(:subscriber).permit(:email)
    end

    def campaign
      if params[:campaign_id]
      else
        @campaign ||= Campaign.active.first
      end
    end
  end
end
