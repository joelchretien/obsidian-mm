describe ImportedFile do
  context '#account' do
    it { should belong_to :account }
  end

  context '#transactions' do
    it { should have_many :transactions }
  end

  context '#source_file' do
    #TODO: Find out how to test active storage in models
  end
end
