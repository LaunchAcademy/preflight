module Preflight
  class Reward < ActiveRecord::Base
    THRESHOLD_TYPES = [
      'campaign_subscription',
      'share'
    ]

    belongs_to :campaign,
      class_name: 'Preflight::Campaign',
      foreign_key: 'campaign_id'

    validates :title, presence: true
    validates :description, presence: true

    validates :campaign, presence: true

    validates :threshold_type,
      inclusion: THRESHOLD_TYPES,
      presence: true

    validates :threshold_units,
      numericality: {
        only_integer: true,
        greater_than: 0
      }

    validates :rank,
      presence: true,
      numericality: {
        only_integer: true,
        greater_than: 0
      },
      uniqueness: {
        scope: :campaign_id
      }
  end
end
