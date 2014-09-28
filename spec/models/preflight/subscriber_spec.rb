require 'rails_helper'

module Preflight
  RSpec.describe Subscriber, :type => :model do
    it { should have_many(:subscriptions).dependent(:destroy) }
    it { should have_many(:campaigns) }
    it { should have_valid(:email).when('user@example.com', 'another@something.co.uk') }
    it { should_not have_valid(:email).when('', nil, 'prefix', 'prefix.', '@aol.com')}

    it 'validates uniqueness of email' do
      subscriber = FactoryGirl.create(:preflight_subscriber)
      other_sub = FactoryGirl.build(:preflight_subscriber)
      other_sub.email = subscriber.email
      expect(other_sub).to_not be_valid
      expect(other_sub.errors[:email]).to_not be_blank
    end

    it 'triggers a configured proc for a subscription' do
      subscriber = FactoryGirl.create(:preflight_subscriber)

      with_temp_config do
        a_mock = mock
        a_mock.expects(:an_action)
        Preflight.configure do |config|
          config.add_subscription_listener ->(s){ a_mock.an_action }
        end
        subscriber.subscribe_to!(FactoryGirl.create(:preflight_campaign))
      end
    end

    def with_temp_config(&block)
      old_config = Preflight.configuration.dup
      block.call
      Preflight.configuration = old_config
    end
  end
end
