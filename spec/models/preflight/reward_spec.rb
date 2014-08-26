require 'rails_helper'

module Preflight
  RSpec.describe Reward, :type => :model do
    it { should belong_to(:campaign) }
    it { should have_valid(:title).when('a title', 'another title') }
    it { should_not have_valid(:title).when(nil, '') }

    it { should have_valid(:description).when('a description', 'another desc')}
    it { should_not have_valid(:description).when(nil, '') }

    it { should have_valid(:campaign).when(Preflight::Campaign.new) }
    it { should_not have_valid(:campaign).when(nil) }

    it { should have_valid(:threshold_units).when(1, 5, 20) }
    it { should_not have_valid(:threshold_units).when(nil, 0, -1) }

    it { should have_valid(:threshold_type).when('share', 'campaign_subscription') }
    it { should_not have_valid(:threshold_type).when(nil, '', 'other')}

    it { should have_valid(:rank).when(1, 3, 5) }
    it { should_not have_valid(:rank).when(nil, 0, -1, -99)}
  end
end
