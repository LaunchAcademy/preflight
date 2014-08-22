require 'rails_helper'

feature 'subscriber returns', %Q{
  As a subsriber
  I want to return to the site
  So that I can refer others
} do
  # Acceptance Criteria
  # * When I navigate to a subscription url, my email is remembered
  # * When my email is remembered I am directed to the sharing center

  let!(:campaign) { FactoryGirl.create(:preflight_campaign) }
  scenario 'subscribe and revisit' do
    visit preflight.root_path
    fill_in 'Email', with: 'user@example.com'
    click_button 'Subscribe'
    expect(page).to have_content('Thanks')

    visit preflight.root_path
    expect(page).to have_content('Share')
  end
end
