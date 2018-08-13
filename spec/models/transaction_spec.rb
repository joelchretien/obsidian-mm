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
end
