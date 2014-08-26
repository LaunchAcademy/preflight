module Preflight
  class Campaign < ActiveRecord::Base
    is_sluggable :title, history: false

    has_many :rewards,
      -> { order(:rank) },
      class_name: 'Preflight::Reward',
      foreign_key: 'campaign_id',
      dependent: :destroy

    include BetterDatePicker::Model

    better_date_picker :started_at
    better_date_picker :ended_at

    validates :title, uniqueness: true, presence: true
    validates :started_at, presence: true
    validate :started_at_before_ended_at

    def started_at_before_ended_at
      if started_at.present? && ended_at.present?
        if ended_at < started_at
          errors.add(:ended_at, 'must be after the start')
        end
      end
    end

    class << self
      def active
        where('started_at <= :now AND (ended_at >= :now OR ended_at IS NULL)',
          now: Time.now)
      end
    end
  end
end
