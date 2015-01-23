FactoryGirl.define do
  factory :post do
    transient do
      matching_tags 0
      tag_array %w[]
    end

    sequence(:title) { |n| "Post ##{n}" }
    description 'Post descriction'
    body { "Post body #{matching_tags}" }

    tag_list do
      tag_array.shuffle.first(matching_tags).join(', ')
    end
  end
end
