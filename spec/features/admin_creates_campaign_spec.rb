require 'rails_helper'

feature 'admin creates campaign', %Q{
  As an admin
  I want to create a campaign
  So that I can encourage users to spread the word
} do
  # Acceptance Criteria:
  # * Only admins can create a campaign
  # * The campaign must have a unique title and permalink

  scenario 'admin creates a valid campaign' do
    sign_in_as(:admin)
    visit preflight.new_admin_campaign_path

    # fill_in 'Title', with: 'A campaign'
    # expect(page).to have_content('Campaign created.')
  end

  scenario 'admin attempts to create invalid campaign'
  scenario 'regular user attempts to create a campaign'
end
