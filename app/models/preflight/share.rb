module Preflight
  class Share < ActiveRecord::Base
    SUPPORTED_PROVIDERS = [
      'facebook',
      'linked_in',
      'twitter'
    ]

    belongs_to :campaign_subscription,
      class_name: 'Preflight::CampaignSubscription',
      foreign_key: 'campaign_subscription_id'

    validates :campaign_subscription,
      presence: true

    validates :provider,
      inclusion: SUPPORTED_PROVIDERS,
      presence: true
  end
end
