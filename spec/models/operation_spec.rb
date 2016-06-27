require 'rails_helper'
  
RSpec.describe Operation, type: :model do
  subject {
      FactoryGirl.build(:operation)
    }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end 

  it "should validates presence of invoice_num" do
    subject.invoice_num = nil
    expect(subject).to_not be_valid 
  end

  it "should validates presence of invoice_date" do
    subject.invoice_date = nil
    expect(subject).to_not be_valid 
  end
  
  it "should validates presence of amount" do
    subject.amount = nil
    expect(subject).to_not be_valid
  end

  it "should validates presence of operation_date" do
    subject.amount = nil
    expect(subject).to_not be_valid
  end

  it "should validates presence of kind" do
     subject.kind = nil
    expect(subject).to_not be_valid
  end

  it "should validates presence of status" do
    subject.status = nil
    expect(subject).to_not be_valid
  end

  context "association" do
    it { is_expected.to have_many(:categories).through(:category_operations) }
  end

  it "should separate categories list from kind column" do
    operation = subject
    operation.save!
    expect(operation.company).to be_valid
  end
      
end
