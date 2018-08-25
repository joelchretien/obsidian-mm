require 'rails_helper'

feature 'upload transaction file' do
  scenario 'with valid file', js: true do
    user = create :user
    account = create :account, user: user
    login_as user, scope: :user
    visit account_transactions_path(account)

    click_link "Upload Transactions"
    attach_file("imported_file_source_file", Rails.root + "spec/fixtures/files/single_transaction_with_headers.csv")
    click_button "Save"

    expect(page).to have_content("Bill1")
  end
end
