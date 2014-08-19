require 'rails_helper'

feature 'user subscribes', %Q{
  As a user interested in a preview
  I want to subscribe
  So that I can be alerted of product updates
} do

  # Acceptance Criteria
  # * I must specify a valid email
  # * If no active campaign is specified, I can still subscribe
  # * If there is no reward system in place, I get confirmation of subscribing
  # * Each campaign subscription has a unique code

  scenario 'subscribe to active campaign with no rewards' do
    campaign = FactoryGirl.create(:preflight_campaign)
    visit preflight.root_path
    fill_in 'Email', with: 'user@example.com'
    click_button 'Subscribe'

    expect(page).to have_content("Thanks! We will keep you posted.")

    last_subscription = Preflight::CampaignSubscription.last
    expect(last_subscription.campaign).to eq(campaign)
    expect(last_subscription.invitation_token).to_not be_blank

  end

  scenario 'invalid email address' do
    visit preflight.root_path
    fill_in 'Email', with: 'a_bad_email'
    click_button 'Subscribe'
    expect(page).to have_content("is invalid")
  end

  scenario 'no active campaigns are present' do
    visit preflight.root_path
    fill_in 'Email', with: 'user@example.com'
    click_button 'Subscribe'

    expect(page).to have_content("Thanks! We will keep you posted.")

    expect(Preflight::Subscriber.last.campaigns).to be_empty
  end
end
