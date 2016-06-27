require 'rails_helper'

RSpec.describe Category, type: :model do
  context "association" do
    it { is_expected.to have_many(:operations).through(:category_operations) }
  end  
end
