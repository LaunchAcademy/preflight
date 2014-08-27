require 'factory_girl'

FactoryGirl.define do
  factory :preflight_campaign, class: Preflight::Campaign do
    sequence(:title) { |n| "Campaign \##{n}" }
    started_at { Time.now - 1.hour }
  end

  factory :preflight_subscriber, class: Preflight::Subscriber do
    sequence(:email) { |n| "user#{n}@example.com"}
  end

  factory :preflight_campaign_subscription,
    class: Preflight::CampaignSubscription do

    association :campaign, factory: :preflight_campaign
    association :subscriber, factory: :preflight_subscriber
  end

  factory :preflight_reward, class: Preflight::Reward do
    association :campaign, factory: :preflight_campaign
    sequence(:title) { |n| "Reward #{n}" }
    description 'a reward for you'
    sequence(:rank) { |n| n }
    sequence(:threshold_units) {|n| n }
    threshold_type 'campaign_subscription'
  end
end
