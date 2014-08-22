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
  def with_temp_config(&block)
    old_config = Preflight.configuration.dup
    block.call
    Preflight.configuration = old_config
  end
end
