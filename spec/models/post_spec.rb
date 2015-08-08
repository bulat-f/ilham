require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#similar' do
    let!(:tag_array) { %w(0 1 2 3 4 5 6 7 8 9) }
    let!(:post) { FactoryGirl.create(:post, tag_array: tag_array, matching_tags: 10) }

    let!(:one_coincident_tag_posts) { FactoryGirl.create_list(:post, 2, tag_array: tag_array, matching_tags: 1) }
    let!(:two_coincident_tag_posts) { FactoryGirl.create_list(:post, 3, tag_array: tag_array, matching_tags: 2) }
    let!(:six_coincident_tag_posts) { FactoryGirl.create_list(:post, 4, tag_array: tag_array, matching_tags: 6) }
    let!(:ten_coincident_tag_posts) { FactoryGirl.create_list(:post, 1, tag_array: tag_array, matching_tags: 10) }

    context 'similar posts less than requested amount' do
      let(:similars) { post.similar 20 }
      it { expect(similars.count).to eq(10) }
    end

    context 'similar posts more requested amount' do
      let(:similars) { post.similar 5 }
      it { expect(similars.count).to eq(5) }
      it { expect(similars).to include(six_coincident_tag_posts.first) }
      it { expect(similars).to include(six_coincident_tag_posts.last) }
      it { expect(similars).to include(ten_coincident_tag_posts.first) }
      it { expect(similars).not_to include(two_coincident_tag_posts.first) }
      it { expect(similars).not_to include(two_coincident_tag_posts.last) }
      it { expect(similars).not_to include(one_coincident_tag_posts.first) }
    end

    context 'not exists similar posts' do
      let(:single) { FactoryGirl.create(:post, tag_array: %w(a b c d e)) }
      let(:similars) { single.similar 10 }
      it { expect(similars.empty?).to eq(true) }
    end
  end
end