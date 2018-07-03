require 'spec_helper'

feature 'Show Budgeted Line Items' do
  scenario 'only shows budgeted line items for the current user' do
    current_user = FactoryBot.create :current_user
    other_user = FactoryBot.create :other_user
    login_as current_user, scope: :user
    visit root_path

    visit budgeted_line_items_path

    expect(page).to have_content(current_user.budgeted_line_items[0].description)
    expect(page).not_to have_content(other_user.budgeted_line_items[0].description)
  end
end
