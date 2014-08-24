require 'rails_helper'

module Preflight
  RSpec.describe Share, :type => :model do
    it { should belong_to :campaign_subscription }

    it { should have_valid(:campaign_subscription).when(CampaignSubscription.new)}
    it { should_not have_valid(:campaign_subscription).when(nil)}

    it { should have_valid(:provider).when('facebook', 'twitter', 'linked_in')}
    it { should_not have_valid(:provider).when(nil, '', 'fsasga', 'myspace')}
  end
end
