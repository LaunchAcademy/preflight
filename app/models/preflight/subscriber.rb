module Preflight
  class Subscriber < ActiveRecord::Base
    has_many :subscriptions,
      class_name: 'Preflight::CampaignSubscription',
      foreign_key: 'subscriber_id',
      inverse_of: :subscriber,
      dependent: :destroy

    has_many :campaigns,
      through: :subscriptions

    #email regexp courtesy of devise:
    #https://github.com/plataformatec/devise/blob/master/lib/devise.rb#L123
    validates :email, uniqueness: true,
      format: Preflight.email_regexp

    def subscribe_to!(campaign, referrer = nil)
      subscription = subscriptions.find_or_initialize_by({
        campaign_id: campaign.id
      })

      referral = false
      if referrer.present? && subscription.referrer_id.blank?
        subscription.referrer = referrer
        referral = true
      end

      subscription.tap do |sub|
        sub.save!

        Preflight.configuration.subscription_listeners.each do |listener|
          listener.call(subscription)
        end

        if referral
          Preflight::RewardDispenserJob.enqueue(referrer.id)
        end
      end
    end
  end
end
