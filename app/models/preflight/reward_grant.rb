module Preflight
  class RewardGrant < ActiveRecord::Base
    belongs_to :reward,
      class_name: 'Preflight::Reward',
      foreign_key: 'reward_id'

    belongs_to :campaign_subscription,
      class_name: 'Preflight::CampaignSubscription',
      foreign_key: 'campaign_subscription_id'

    validates :reward, presence: true
    validates :campaign_subscription, presence: true
  end
end
