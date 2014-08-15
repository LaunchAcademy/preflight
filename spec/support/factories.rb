require 'factory_girl'

FactoryGirl.define do
  factory :preflight_campaign, class: Preflight::Campaign do
    sequence(:title) { |n| "Campaign \##{n}" }
    started_at { Time.now - 1.hour }
  end

end
