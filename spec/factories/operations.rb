FactoryGirl.define do
  factory :operation do
    invoice_num "Anynumber"
    invoice_date DateTime.now
    amount 25
    operation_date DateTime.now
    kind "anything1;anything2"
    status "anystatus"
    association :company
  end
end
