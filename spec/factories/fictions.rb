FactoryGirl.define do
  factory :fiction do
    title 'Fiction name'
    body  'Fiction description'
    price 100
    author
    genre
    cover File.open(File.join(Rails.root, '/shared/slide0.jpg'))
  end
end
