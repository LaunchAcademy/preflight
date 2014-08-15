require 'rails_helper'

module Preflight
  RSpec.describe Campaign, :type => :model do
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
  end
end
