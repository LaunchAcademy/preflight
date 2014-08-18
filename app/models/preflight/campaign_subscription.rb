module Preflight
  class CampaignSubscription < ActiveRecord::Base
    belongs_to :campaign
    belongs_to :subscriber
    belongs_to :referrer,
      class_name: "Preflight::CampaignSubscription",
      foreign_key: "referrer_id"

    validates :campaign,
      presence: true,
      uniqueness: {scope: :subscriber_id}

    validates :subscriber, presence: true
  end
end
