require "spec_helper"

feature "Show Transactions" do
  scenario "only shows transactions for the current user" do
    user = create_user_with_transactions()
    account = user.accounts[0]
    other_user = create_user_with_transactions()
    other_account = other_user.accounts[0]
    login_as user, scope: :user

    visit account_transactions_path(account)

    expect(page).to have_content(account.transactions[0].description)
    expect(page).not_to have_content(other_account.transactions[0].description)
  end

  scenario "paginates transactions" do
    user = create_user_with_transactions()
    transactions = user.accounts[0].transactions
    allow(Transaction).to receive(:per_page).and_return(2)

    login_as user, scope: :user
    visit account_transactions_path(user.accounts[0])

    expect(page).to have_css(".pagination")
    expect(page).to have_content(transactions[2].description)
    expect(page).not_to have_content(transactions[0].description)

    click_link "2"

    expect(page).to have_css(".pagination")
    expect(page).not_to have_content(transactions[2].description)
    expect(page).to have_content(transactions[0].description)
  end

  def create_user_with_transactions
    user = FactoryBot.create :user
    account = FactoryBot.create :account, user: user
    imported_file = FactoryBot.create :imported_file, account: account
    FactoryBot.create_list(:transaction, 3, account: account, imported_file: imported_file)
    user
  end
end
