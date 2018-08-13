describe User do
  context "associations" do
    it { should have_many(:accounts).dependent(:destroy)}
  end
end
