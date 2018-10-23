require "spec_helper"

feature "Show Budgeted Line Items" do
  scenario "only shows budgeted line items for the current user" do
    current_user = create_current_user_with_budgeted_line_items()
    account = current_user.accounts.first
    other_user = create_other_user_with_budgeted_line_items()
    other_account = other_user.accounts.first
    login_as current_user, scope: :user

    visit account_budgeted_line_items_path account

    expect(page).to have_content(account.budgeted_line_items[0].description)
    expect(page).not_to have_content(other_account.budgeted_line_items[0].description)
  end

  scenario "paginates budgeted line items" do
    current_user = create_current_user_with_budgeted_line_items()
    account = current_user.accounts.first
    transactions = account.budgeted_line_items.alphabetical
    allow(BudgetedLineItem).to receive(:per_page).and_return(2)

    login_as current_user, scope: :user
    visit account_budgeted_line_items_path(account)

    expect(page).to have_css(".pagination")
    expect(page).to have_content(transactions[0].description)
    expect(page).not_to have_content(transactions[2].description)

    click_link "2"

    expect(page).to have_css(".pagination")
    expect(page).not_to have_content(transactions[0].description)
    expect(page).to have_content(transactions[2].description)
  end

  def create_current_user_with_budgeted_line_items
    user = FactoryBot.create :user
    account = FactoryBot.create :account, user: user
    FactoryBot.create_list(:budgeted_line_item, 3, account: account)
    user
  end

  def create_other_user_with_budgeted_line_items
    user = FactoryBot.create :user
    account = FactoryBot.create :account, user: user
    FactoryBot.create_list(:budgeted_line_item, 3, account: account)
    user
  end
end
