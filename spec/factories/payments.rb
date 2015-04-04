FactoryGirl.define do
  factory :payment do
    fiction
    user
    # after(:create) do |payment, evaluator|
    #   payment.sum evaluator.fiction.price
    # end
  end
end
