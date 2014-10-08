module Preflight
  class SubscribersController < ApplicationController
    respond_to :html
    before_action :check_subscription

    def new
      @subscriber = Subscriber.new
    end

    def create
      opt_in = Preflight::OptIn.new(
        subscriber_params,
        campaign,
        request,
        cookies)

      opt_in.save
      @subscriber = opt_in.subscriber
      redir_path = root_path

      respond_with(@subscriber, location: redirection_url(opt_in.subscription))
    end

    protected
    def redirection_url(sub)
      if Preflight.configuration.post_subscription_url
        the_proc = Preflight.configuration.post_subscription_url
        instance_eval(&the_proc)
      else
        if sub
          redir_path = sharing_center_path
        else
          root_path
        end
      end
    end
    def check_subscription
      if cookies.signed[Preflight.subscription_cookie_key]
        redirect_to sharing_center_path
      end
    end

    def subscriber_params
      params.require(:subscriber).permit(:email)
    end

    def campaign
      if params[:campaign_id]
        @campaign ||= Campaign.find_using_slug!(params[:campaign_id])
      else
        @campaign ||= Campaign.active.first
      end
    end
  end
end
