FactoryGirl.define do
  factory :gift do
    association :presentee, factory: :user
    association :present,   factory: :fiction
    payment
  end
end
