require 'rails_helper'

module Preflight
  RSpec.describe RewardGrant, :type => :model do
    it { should belong_to :campaign_subscription }
    it { should belong_to :reward }

    it { should have_valid(:campaign_subscription).when(
      Preflight::CampaignSubscription.new)}
    it { should_not have_valid(:campaign_subscription).when(nil) }

    it { should have_valid(:reward).when(Preflight::Reward.new)}
    it { should_not have_valid(:reward).when(nil)}
  end
end
