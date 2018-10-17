describe UserEnteredBalance do
  context "#account" do
    it { is_expected.to belong_to(:account) }
    it { is_expected.to validate_presence_of(:account) }
  end

  context "#balance_transaction" do
    it { is_expected.to belong_to(:balance_transaction) }
    it { is_expected.to validate_presence_of(:balance_transaction) }
  end

  context "#balance_cents" do
    it { is_expected.to monetize(:balance_cents) }
    it { is_expected.to validate_presence_of(:balance_cents) }
  end
end
