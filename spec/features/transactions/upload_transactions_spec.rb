require "rails_helper"

feature "upload transaction file" do
  context "with valid file and balance" do
    scenario "shows transaction name", js: true do
      visit_transactions_page

      upload_transactions(
        file: "single_transaction_with_headers.csv",
        last_balance: 10.10
      )

      expect(page).to have_content("Bill1")
    end

    scenario "shows transaction amount", js: true do
      visit_transactions_page

      upload_transactions(
        file: "single_transaction_with_headers.csv",
        last_balance: 10.10
      )

      expect(page).to have_content("1.00")
    end

    scenario "shows transaction balance", js: true do
      visit_transactions_page

      upload_transactions(
        file: "single_transaction_with_headers.csv",
        last_balance: 10
      )

      expect_transaction_with_name_to_have_balance(
        name: "Bill1",
        balance: 10
      )
    end

    scenario "shows previous transaction balance when it's the first file", js: true do
      visit_transactions_page

      upload_transactions(
        file: "two_transactions_part_one.csv",
        last_balance: 10
      )

      expect_transaction_with_name_to_have_balance(
        name: "Bill1",
        balance: 12
      )
    end

    scenario "shows transaction balance when it's the second file", js: true do
      visit_transactions_page

      upload_transactions(
        file: "two_transactions_part_one.csv",
        last_balance: 10
      )
      upload_transactions(
        file: "two_transactions_part_two.csv"
      )

      expect_transaction_with_name_to_have_balance(
        name: "Bill3",
        balance: 9
      )
    end
  end

  context "with double-quotes in file" do
    it "escapes the double-quotes" do
      visit_transactions_page

      upload_transactions(
        file: "single_transaction_with_double_quotes.csv",
        last_balance: 10.10
      )

      expect(page).to have_content("My Bill ")
    end
  end

  def expect_transaction_with_name_to_have_balance(name:, balance:)
    expect(page).to have_content(name)
    row = find("tr", text: name)
    expect(row).to have_content(balance)
  end

  def visit_transactions_page
    user = create :user
    account = create :account, user: user
    login_as user, scope: :user
    visit account_transactions_path(account)
  end

  def upload_transactions(file:, last_balance: nil)
    click_link "Upload Transactions"
    attach_file(
      "import_file_request_source_file",
      Rails.root + "spec/fixtures/files/#{file}"
    )

    if !last_balance.nil?
      fill_in "last-balance", with: last_balance
    end
    click_button "Save"
  end
end
