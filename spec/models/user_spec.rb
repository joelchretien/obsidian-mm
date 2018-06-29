describe User do
  context "associations" do
    it { should have_many(:transactions).dependent(:destroy)}
    it { should have_many(:budgeted_line_items).dependent(:destroy)}
  end
end
