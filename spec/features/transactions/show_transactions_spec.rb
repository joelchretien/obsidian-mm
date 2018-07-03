require 'spec_helper'

feature 'Show Transactions' do
  scenario 'only shows transactions for the current user' do
    current_user = FactoryBot.create :current_user
    other_user = FactoryBot.create :other_user
    login_as current_user, scope: :user
    visit root_path

    visit transactions_path

    expect(page).to have_content(current_user.transactions[0].description)
    expect(page).not_to have_content(other_user.transactions[0].description)
  end

  scenario 'paginates transactions' do
    current_user = FactoryBot.create :current_user
    # generate(:current_user_transactions)
    allow(Transaction).to receive(:per_page).and_return(1)

    login_as current_user, scope: :user
    visit transactions_path

    expect(page).to have_css('.pagination')
  end
end
