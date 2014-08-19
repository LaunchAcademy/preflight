module Preflight
  class SubscribersController < ApplicationController
    respond_to :html

    def new
      @subscriber = Subscriber.new
    end

    def create
      opt_in = Preflight::OptIn.new(subscriber_params, campaign, request)

      opt_in.save
      @subscriber = opt_in.subscriber
      respond_with(@subscriber, location: root_path)
    end

    protected
    def subscriber_params
      params.require(:subscriber).permit(:email)
    end

    def campaign
      if params[:campaign_id]
        @campaign ||= Campaign.find_using_slug!(params[:id])
      else
        @campaign ||= Campaign.active.first
      end
    end
  end
end
