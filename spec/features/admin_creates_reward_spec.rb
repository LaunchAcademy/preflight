require 'rails_helper'

feature 'admin creates a reward', %Q{
  As an admin
  I want to create a reward for referring users
  So that I can incentivize sharing
} do
  let(:campaign) do
    FactoryGirl.create(:preflight_campaign)
  end

  scenario 'admin specifies a valid reward' do
    sign_in_as(:admin)
    visit preflight.new_admin_campaign_reward_path(campaign)
    fill_in 'Title', with: 'A New Car!'
    fill_in 'Description', with: 'The price is right'
    fill_in 'Referral Threshold', with: 3
    fill_in 'Rank', with: 1

    click_button 'Create Reward'
    expect(page).to have_content('Reward created.')
  end

  scenario 'admin specifies an invalid reward' do
    sign_in_as(:admin)
    visit preflight.new_admin_campaign_reward_path(campaign)
    click_button 'Create Reward'
    expect(page).to have_content("can't be blank")
  end

  scenario 'user attempts to add a reward' do
    sign_in_as(:user)
    visit preflight.new_admin_campaign_reward_path(campaign)
    expect(page).to have_content('Access Denied')
  end

  scenario 'unauthenticated user attempts to add a reward' do
    visit preflight.new_admin_campaign_reward_path(campaign)
    expect(page).to have_content('Access Denied')
  end
end
