feature 'upload transaction file' do
  scenario 'with valid file' do
    current_user = FactoryBot.create :current_user
    login_as current_user, scope: :user
    visit transactions_path

    attach_file("Upload Transactions", Rails.root + "spec/fixtures/file/single_transactioni_with_headers.csv")

    expect(current_user.transactions.count).to eq(1)
    transaction = current_user.transactions[0]
    expect(transaction.description).to eq("Bill1")
    expect(transaction.description).to eq("Bill1")
    expect(transaction.description).to eq("Bill1")
    
    expect
  end
end
