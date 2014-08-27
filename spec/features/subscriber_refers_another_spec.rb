require 'rails_helper'

feature 'Subscriber refers another subscriber', %Q{
  As a subscriber
  I want to refer other subscribers
  So that they can be informed and I can be rewarded
} do

  let!(:referring_subscription) do
    FactoryGirl.create(:preflight_campaign_subscription)
  end

  scenario 'valid referral link via query string' do
    visit preflight.root_path(ref: referring_subscription.invitation_token)
    fill_in 'Email', with: 'anotheruser@example.com'
    click_button 'Subscribe'
    expect(page).to have_content('Thanks!')

    last_sub = Preflight::CampaignSubscription.last
    expect(last_sub.referrer).to eq(referring_subscription)
  end

  scenario 'valid referral link' do
    visit preflight.referral_path(referring_subscription)
    fill_in 'Email', with: 'anotheruser@example.com'
    click_button 'Subscribe'
    expect(page).to have_content('Thanks!')

    last_sub = Preflight::CampaignSubscription.last
    expect(last_sub.referrer).to eq(referring_subscription)
  end

  scenario 'invalid referral link' do
    visit preflight.referral_path('51234123415')
    fill_in 'Email', with: 'anotheruser@example.com'
    click_button 'Subscribe'
    expect(page).to have_content('Thanks!')

    last_sub = Preflight::CampaignSubscription.last
    expect(last_sub.referrer).to be_nil
  end

  scenario 'referring user gets rewarded' do
    FactoryGirl.create(:preflight_reward,
      campaign: referring_subscription.campaign)

    visit preflight.root_path(ref: referring_subscription.invitation_token)
    fill_in 'Email', with: 'anotheruser@example.com'
    click_button 'Subscribe'
    expect(page).to have_content('Thanks!')

    browser = Capybara.current_session.driver.browser
    browser.clear_cookies

    visit preflight.root_path
    fill_in 'Email', with: referring_subscription.subscriber.email
    click_button 'Subscribe'

    expect(page).to have_content('You have earned 1 reward!')
  end
end
