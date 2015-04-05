FactoryGirl.define do
  factory :fiction do
    title 'Fiction name'
    body  'Fiction description'
    price 100
    author
    after :create do |fiction|
      fiction.update_column(:cover, Rails.root + '/shared/slide0.jpg')
    end
  end
end
