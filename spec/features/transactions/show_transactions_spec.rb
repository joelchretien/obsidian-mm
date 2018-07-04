require 'spec_helper'

feature 'Show Transactions' do
  scenario 'only shows transactions for the current user' do
    current_user = create_current_user_with_transactions()
    other_user = create_other_user_with_transactions()
    login_as current_user, scope: :user
    visit root_path

    visit transactions_path

    expect(page).to have_content(current_user.transactions[0].description)
    expect(page).not_to have_content(other_user.transactions[0].description)
  end

  scenario 'paginates transactions' do
    current_user = create_current_user_with_transactions()
    transactions = current_user.transactions
    allow(Transaction).to receive(:per_page).and_return(2)

    login_as current_user, scope: :user
    visit transactions_path

    expect(page).to have_css('.pagination')
    expect(page).to have_content(transactions[0].description)
    expect(page).not_to have_content(transactions[2].description)

    click_link "2"

    expect(page).to have_css('.pagination')
    expect(page).not_to have_content(transactions[0].description)
    expect(page).to have_content(transactions[2].description)
  end

  def create_current_user_with_transactions()
    current_user = FactoryBot.create :current_user
    FactoryBot.create_list(:current_user_transactions, 3, user: current_user)
    current_user
  end
  
  def create_other_user_with_transactions()
    other_user = FactoryBot.create :other_user
    FactoryBot.create_list(:current_user_transactions, 3, user: other_user)
    other_user
  end
end
