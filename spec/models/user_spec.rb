require 'rails_helper'

describe User do
  context "associations" do
    it { should have_many(:transactions).dependent(:destroy)}
  end
end
