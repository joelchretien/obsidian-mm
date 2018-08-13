
describe Account do
  context "associations" do
    it { should have_many(:transactions).dependent(:destroy)}
    it { should have_many(:budgeted_line_items).dependent(:destroy)}
  end

  context "#name" do
    it { is_expected.to validate_presence_of(:name)}
  end
end
