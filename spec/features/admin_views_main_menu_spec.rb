require 'rails_helper'

feature 'admin views main menu', %Q{
  As an admin
  I want to administer preflight
  So that I can manage campaigns
} do
  # Acceptance Criteria:
  # * Only admins can view the menu

  scenario 'admin views menu' do
    sign_in_as(:admin)
    visit preflight.admin_path
  end

  scenario 'regular user attempts to view menu' do
    sign_in_as(:user)
    visit preflight.admin_path
    expect(page).to have_content('Access Denied')
  end

  scenario 'unauthenticated user attempts to view menu' do
    visit preflight.admin_path
    expect(page).to have_content('Access Denied')
  end
end
