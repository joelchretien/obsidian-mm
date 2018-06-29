describe Transaction do
  context "association" do
    it { should belong_to(:user)}
  end
end
