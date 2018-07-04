require 'spec_helper'

feature 'Show Budgeted Line Items' do
  scenario 'only shows budgeted line items for the current user' do
    current_user = create_current_user_with_budgeted_line_items()
    other_user = create_other_user_with_budgeted_line_items()
    login_as current_user, scope: :user
    visit root_path

    visit budgeted_line_items_path

    expect(page).to have_content(current_user.budgeted_line_items[0].description)
    expect(page).not_to have_content(other_user.budgeted_line_items[0].description)
  end

  scenario 'paginates budgeted line items' do
    current_user = create_current_user_with_budgeted_line_items()
    transactions = current_user.budgeted_line_items
    allow(BudgetedLineItem).to receive(:per_page).and_return(2)

    login_as current_user, scope: :user
    visit budgeted_line_items_path

    expect(page).to have_css('.pagination')
    expect(page).to have_content(transactions[0].description)
    expect(page).not_to have_content(transactions[2].description)

    click_link "2"

    expect(page).to have_css('.pagination')
    expect(page).not_to have_content(transactions[0].description)
    expect(page).to have_content(transactions[2].description)
  end

  def create_current_user_with_budgeted_line_items()
    current_user = FactoryBot.create :current_user
    FactoryBot.create_list(:current_user_bugeted_line_items, 3, user: current_user)
    current_user
  end

  def create_other_user_with_budgeted_line_items()
    other_user = FactoryBot.create :other_user
    FactoryBot.create_list(:current_user_bugeted_line_items, 3, user: other_user)
    other_user
  end
end
