FactoryGirl.define do
  factory :purchase_payment, class: 'Payment' do
    association :payable, factory: :purchase
  end

  factory :gift_payment, class: 'Payment' do
    association :payable, factory: :gift
  end
end
