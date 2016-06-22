require 'rails_helper'

RSpec.describe Category, type: :model do
  it "should validates presence of name" do
  end
  context "association" do
    it { is_expected.to have_many(:operations).through(:category_operations) }
  end
end
