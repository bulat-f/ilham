FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_no_#{n}@mail.com" }

    password              'password123'
    password_confirmation 'password123'

    trait :writer do
      writer true
    end

    trait :admin do
      admin true
    end

    factory :writer, aliases: [:author], traits: [:writer]
    factory :admin,                      traits: [:admin]
  end
end
