require 'rails_helper'

module Preflight
  RSpec.describe OptIn, :type => :model do
    let(:campaign){ FactoryGirl.create(:preflight_campaign) }

    it 'creates a new subscriber if email is not found' do
      opt_in = Preflight::OptIn.new({email: 'user@example.com'}, campaign)
      expect(opt_in.save).to be(true)
      expect(opt_in.subscriber).to be_persisted
    end

    it 'updates an existing subscriber if email is found' do
      subscriber = FactoryGirl.create(:preflight_subscriber)
      opt_in = Preflight::OptIn.new({email: subscriber.email}, campaign)
      expect(opt_in.save).to be(true)
      expect(subscriber.campaigns).to include(campaign)
    end

    it 'only enrolls a subscriber in a campaign once' do
      subscriber = FactoryGirl.create(:preflight_subscriber)
      subscriber.subscribe_to!(campaign)
      opt_in = Preflight::OptIn.new({email: subscriber.email}, campaign)
      expect(opt_in.save).to be(true)
      expect(subscriber.campaigns.count).to eq(1)
    end

    it 'returns a subscription when a campaign is present' do

      subscriber = FactoryGirl.create(:preflight_subscriber)
      sub = subscriber.subscribe_to!(campaign)
      expect(sub).to be_kind_of(Preflight::CampaignSubscription)
    end
  end
end
