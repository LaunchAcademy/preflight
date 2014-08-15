require 'rails_helper'

feature 'admin creates campaign', %Q{
  As an admin
  I want to create a campaign
  So that I can encourage users to spread the word
} do
  # Acceptance Criteria:
  # * Only admins can create a campaign
  # * The campaign must have a unique title and permalink
  # * It requires a start date
  # * It optionally allows an end date

  scenario 'admin creates a valid campaign' do
    sign_in_as(:admin)
    visit preflight.new_admin_campaign_path

    fill_in 'Title', with: 'A campaign'
    fill_in 'Starts', with: 'Tomorrow'
    click_button 'Create Campaign'

    expect(page).to have_content('Campaign created.')
  end

  scenario 'admin attempts to create invalid campaign' do
    sign_in_as(:admin)
    visit preflight.new_admin_campaign_path

    click_button 'Create Campaign'

    expect(page).to have_content("can't be blank")
  end

  scenario 'regular user attempts to create a campaign' do
    sign_in_as(:user)
    visit preflight.new_admin_campaign_path

    expect(page).to have_content('Access Denied')
  end

  scenario 'unauthenticated user attempts to create a campaign' do
    visit preflight.new_admin_campaign_path
    expect(page).to have_content('Access Denied')
  end
end
