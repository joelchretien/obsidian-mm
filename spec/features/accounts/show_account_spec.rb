feature 'show account dashboard' do
  scenario 'account dashboard shows current transactions' do
    user = create :user
    login_as user
    account = create :account, user: user
    imported_file = create :imported_file, account: account
    transaction = create :transaction, account: account, imported_file: imported_file, transaction_date: Date.today

    visit account_path(account)

    expect(page).to have_content(transaction.description)
  end
end
