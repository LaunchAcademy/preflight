require 'rails_helper'

describe Preflight::RewardDispenserJob do
  let(:reward) do
    FactoryGirl.create(:preflight_reward,
      threshold_units: 1)
  end

  let(:campaign) do
    reward.campaign
  end

  let(:subscription) do
    FactoryGirl.create(:preflight_campaign_subscription,
      campaign: campaign)
  end

  let(:referral) do
    FactoryGirl.create(:preflight_campaign_subscription,
      campaign: campaign,
      referrer: subscription)
  end

  it 'grants applicable rewards' do
    referral

    job = Preflight::RewardDispenserJob.new
    job.perform(subscription.id)

    expect(subscription.reward_grants.count).to eq(1)
  end

  it 'does not grant rewards twice' do
    referral

    FactoryGirl.create(:preflight_campaign_subscription,
      campaign: campaign,
      referrer: subscription)

    job = Preflight::RewardDispenserJob.new
    job.perform(subscription.id)

    expect(subscription.reward_grants.count).to eq(1)
  end
end
