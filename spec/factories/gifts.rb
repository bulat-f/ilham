FactoryGirl.define do
  factory :gift do |g|
    user
    association :presentee, factory: :user
    association :present,   factory: :fiction
  end
end
