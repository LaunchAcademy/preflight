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
      format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

    def subscribe_to!(campaign, referrer = nil)
      subscription = subscriptions.find_or_initialize_by({
        campaign_id: campaign.id
      })

      if referrer.present?
        subscription.referrer = referrer
      end

      subscription.tap do |sub|
        sub.save!
      end
    end
  end
end
