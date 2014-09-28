require 'spec_helper'

describe Preflight::Configuration do
  it 'has a github key' do
    github_key = 'key'
    with_temp_config do
      Preflight.configure do |config|
        config.github_key = github_key
      end
      expect(Preflight.configuration.github_key).to eq(github_key)
    end
  end

  it 'has a github secret key' do
    github_secret = 'secret'
    with_temp_config do
      Preflight.configure do |config|
        config.github_secret_key = github_secret
      end
      expect(Preflight.configuration.github_secret_key).to eq(github_secret)
    end
  end

  it 'has a list of admin teams' do
    teams = ['experience engineers']
    with_temp_config do
      Preflight.configure do |config|
        config.admin_teams = teams
      end
      expect(Preflight.configuration.admin_teams).to eq(teams)
    end
  end

  it 'has a fb app id' do
    app_id = 'fb_whatevah'
    with_temp_config do
      Preflight.configure do |config|
        config.facebook_app_id = app_id
      end

      expect(Preflight.configuration.facebook_app_id).to eq(app_id)
    end
  end

  it 'has a twitter handle' do
    handle = 'launchacademy_'
    with_temp_config do
      Preflight.configure do |config|
        config.twitter_handle = handle
      end

      expect(Preflight.configuration.twitter_handle).to eq(handle)
    end
  end

  it 'has a linked in api key' do
    key = 'some_key'
    with_temp_config do
      Preflight.configure do |config|
        config.linked_in_api_key = key
      end

      expect(Preflight.configuration.linked_in_api_key).to eq(key)
    end
  end

  it 'has a after_subscription proc' do
    with_temp_config do
      the_proc = ->(s){puts 'yo' }
      Preflight.configure do |config|
        config.add_subscription_listener the_proc
      end
    end

    expect(Preflight.configuration.subscription_listeners).to_not be_empty
  end

  def with_temp_config(&block)
    old_config = Preflight.configuration.dup
    block.call
    Preflight.configuration = old_config
  end
end
