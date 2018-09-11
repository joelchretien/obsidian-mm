describe Transaction do
  context "#account" do
    it { is_expected.to belong_to(:account)}
    it { is_expected.to validate_presence_of(:account)}
  end

  context "#budgeted_line_item" do
    it { is_expected.to belong_to(:budgeted_line_item)}
  end

  context "#description" do
    it { is_expected.to validate_presence_of(:description)}
  end

  context "#transaction_date" do
    it { is_expected.to validate_presence_of(:transaction_date)}
  end

  context "#amount_cents" do
    it { is_expected.to monetize(:amount_cents)}
    it { is_expected.to validate_presence_of(:amount_cents) }
  end

  context "#imported_file" do
    it { is_expected.to belong_to :imported_file }
    it { is_expected.to validate_presence_of :imported_file }
  end

  context "#is_duplicate" do
    it 'returns true when description, amount and transaction_date match' do
      description = 'desc'
      transaction_date = Date.today
      amount = 5
      transaction1 = Transaction.new(description: description, transaction_date: transaction_date, amount: amount)
      transaction2 = Transaction.new(description: description, transaction_date: transaction_date, amount: amount)
      expect(transaction1.is_duplicate(transaction2)).to be(true)
    end
    it 'returns false when the amount does not match' do
      description = 'desc'
      transaction_date = Date.today
      transaction1 = Transaction.new(description: description, transaction_date: transaction_date, amount: 5)
      transaction2 = Transaction.new(description: description, transaction_date: transaction_date, amount: 3)
      expect(transaction1.is_duplicate(transaction2)).to be(false)
    end
    it 'returns false when the description does not match' do
      transaction_date = Date.today
      amount = 5
      transaction1 = Transaction.new(description: 'desc1', transaction_date: transaction_date, amount: amount)
      transaction2 = Transaction.new(description: 'desc2', transaction_date: transaction_date, amount: amount)
      expect(transaction1.is_duplicate(transaction2)).to be(false)
    end
    it 'returns false when the amount does not match' do
      description = 'desc'
      amount = 5
      transaction1 = Transaction.new(description: description, transaction_date: Date.today, amount: amount)
      transaction2 = Transaction.new(description: description, transaction_date: Date.today + 1.day, amount: amount)
      expect(transaction1.is_duplicate(transaction2)).to be(false)
    end
  end
end
