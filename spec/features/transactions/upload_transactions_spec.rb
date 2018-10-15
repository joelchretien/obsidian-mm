require "rails_helper"

feature "upload transaction file" do
  scenario "with valid file and balance", js: true do
    user = create :user
    account = create :account, user: user
    login_as user, scope: :user
    visit account_transactions_path(account)

    click_link "Upload Transactions"
    attach_file("import_file_request_source_file", Rails.root + "spec/fixtures/files/single_transaction_with_headers.csv")
    fill_in "last-balance", with: "10"
    click_button "Save"

    expect(page).to have_content("Bill1")
  end
end
