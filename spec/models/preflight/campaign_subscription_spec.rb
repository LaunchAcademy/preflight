require 'rails_helper'

module Preflight
  RSpec.describe CampaignSubscription, :type => :model do
    it { should belong_to(:campaign) }
    it { should belong_to(:subscriber) }
    it { should belong_to(:referrer) }
    it { should have_many(:shares).dependent(:destroy) }
    it { should have_many(:reward_grants) }
    it { should have_many(:rewards) }
    it { should have_many(:referrals).dependent(:nullify) }

    it { should have_valid(:campaign).when(Preflight::Campaign.new)}
    it { should_not have_valid(:campaign).when(nil) }

    it { should have_valid(:subscriber).when(Preflight::Subscriber.new) }
    it { should_not have_valid(:subscriber).when(nil) }

    it 'requires a unique subscriber and campaign' do
      sub = FactoryGirl.create(:preflight_campaign_subscription)
      other_sub = FactoryGirl.build(:preflight_campaign_subscription)

      other_sub.subscriber = sub.subscriber
      other_sub.campaign = sub.campaign
      expect(other_sub).to_not be_valid
      expect(other_sub.errors[:campaign]).to_not be_blank
    end

    it 'requires a unique invitation token per campaign' do
      sub = FactoryGirl.create(:preflight_campaign_subscription)
      other_sub = FactoryGirl.build(:preflight_campaign_subscription,
        campaign: sub.campaign,
        invitation_token: sub.invitation_token)
      expect(other_sub).to_not be_valid
      expect(other_sub.errors[:invitation_token]).to_not be_blank
    end

    it 'generates a unique invitation_code' do
      sub = FactoryGirl.create(:preflight_campaign_subscription,
        invitation_token: nil)
      sub.save!
      expect(sub.invitation_token).to_not be_blank
    end
  end
end
