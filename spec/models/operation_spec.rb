require 'rails_helper'

RSpec.describe Operation, type: :model do
  subject {
      described_class.new(invoice_num: "Anynumber", invoice_date: DateTime.now,
                        amount: 25, operation_date: DateTime.now, kind: "anything1;anything2",
                        status: "anystatus")
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
      
end
