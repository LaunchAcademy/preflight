module Preflight
  class RewardDispenserJob < ::ActiveJob::Base
    queue_as :default

    def perform(sub_id)
      sub = Preflight::CampaignSubscription.where(id: sub_id).first
      if sub.present?
        rewarded_ids = sub.reward_grants.pluck(:reward_id)
        rewards_to_grant = sub.campaign.rewards.where(
          "threshold_units <= :unit_count",
          unit_count: sub.referrals.count
        )

        if rewarded_ids.present?
          rewards_to_grant = rewards_to_grant.where("id NOT IN (:ids)",
            ids: rewarded_ids
          )
        end

        rewards_to_grant.each do |reward|
          sub.reward_grants.create! do |grant|
            grant.reward = reward
          end
        end
      end
    end
  end
end
