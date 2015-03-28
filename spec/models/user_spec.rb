require 'rails_helper'

describe User do
  describe '#can_read?' do
    let(:fiction) { FactoryGirl.create :fiction }

    context 'admin user' do
      let(:admin) { FactoryGirl.create :admin }
      it { expect(admin.can_read?(fiction)).to eq(true) }
    end

    context 'author' do
      let(:author)  { FactoryGirl.create :author }
      let(:own_fiction) { FactoryGirl.create :fiction, author: author }
      it { expect(author.can_read?(own_fiction)).to eq(true) }
    end

    context 'purchased by the user' do
      let(:user) { FactoryGirl.create :user }
      before { user.purchases.create(fiction_id: fiction.id) }
      it { expect(user.can_read?(fiction)).to eq(true) }
    end

    context 'other user' do
      let(:user) { FactoryGirl.create :user }
      it { expect(user.can_read?(fiction)).to eq(false) }
    end
  end

  describe '#buy!' do
    let(:fiction) { FactoryGirl.create :fiction }
    let(:user) { FactoryGirl.create :user }

    context 'ActiveRecord object as argument' do
      before { user.buy!(fiction) }
      it { expect(user.bought?(fiction)).to eq(true) }
    end

    context 'Fixnum as argument' do
      before { user.buy!(fiction.id) }
      it { expect(user.bought?(fiction)).to eq(true) }
    end
  end
end
