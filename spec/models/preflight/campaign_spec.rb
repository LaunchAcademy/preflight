require 'rails_helper'

module Preflight
  RSpec.describe Campaign, :type => :model do
    it { should have_many(:rewards).dependent(:destroy) }

    it { should have_valid(:title).when('A title', 'Another title') }
    it { should_not have_valid(:title).when(nil, '') }

    context 'title uniqueness' do
      it 'is required' do
        campaign = FactoryGirl.create(:preflight_campaign)

        dupe_campaign = FactoryGirl.build(:preflight_campaign)
        dupe_campaign.title = campaign.title

        expect(dupe_campaign.save).to be(false)
        expect(dupe_campaign.errors[:title]).to_not be_empty
      end
    end

    it { should have_valid(:started_at).when(Time.now, 1.day.ago, 1.day.from_now) }
    it { should_not have_valid(:started_at).when(nil) }

    it { should have_valid(:ended_at).when(Time.now, 1.day.ago, 1.day.from_now)}

    it 'cannot have an ended_at before started_at' do
      campaign = FactoryGirl.create(:preflight_campaign)
      campaign.ended_at = campaign.started_at - 1.day
      expect(campaign).to_not be_valid
      expect(campaign.errors[:ended_at]).to_not be_nil
    end

    context 'active campaigns' do
      it 'includes campaigns that have started but not ended' do
        campaign = FactoryGirl.create(:preflight_campaign)
        expect(Campaign.active).to include(campaign)
      end

      it 'includes campaigns that have started and have no end date' do
        campaign = FactoryGirl.create(:preflight_campaign, ended_at: nil)
        expect(Campaign.active).to include(campaign)
      end

      it 'discludes campaigns that have not started' do
        unstarted_campaign = FactoryGirl.create(:preflight_campaign,
          started_at: 4.days.from_now)
        expect(Campaign.active).to_not include(unstarted_campaign)
      end

      it 'discludes campaigns that have already ended' do
        expired_campaign = FactoryGirl.create(:preflight_campaign,
          started_at: 5.days.ago,
          ended_at: 4.days.ago)
        expect(Campaign.active).to_not include(expired_campaign)
      end
    end
  end
end
