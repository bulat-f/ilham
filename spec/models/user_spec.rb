require 'rails_helper'

describe User do
  describe '#can_read?' do
    let(:fiction) { FactoryGirl.create :fiction }

    context 'admin user' do
      let(:admin) { FactoryGirl.create :admin }
      it { expect(admin.can_read?(fiction)).to eq(true) }
    end

    context 'author' do
      let(:author)      { FactoryGirl.create :author }
      let(:own_fiction) { FactoryGirl.create :fiction, author: author }
      it { expect(author.can_read?(own_fiction)).to eq(true) }
    end

    context 'purchased by the user' do
      let(:user) { FactoryGirl.create :user }
      before { user.purchases.create(fiction_id: fiction.id) }
      context 'before pay' do
        it { expect(user.can_read?(fiction)).to eq(false) }
      end

      context 'before pay' do
        before { user.purchases.last.pay! }
        it { expect(user.can_read?(fiction)).to eq(true) }
      end
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
      it { expect{ user.buy!(fiction) }.to change(user.purchases, :count) }
    end

    context 'Fixnum as argument' do
      it { expect{ user.buy!(fiction.id) }.to change(user.purchases, :count) }
    end
  end

  describe '#received?' do
    let(:user)    { FactoryGirl.create :user }
    let(:present) { FactoryGirl.create :fiction }
    let(:gift)    { FactoryGirl.create :gift, presentee: user, present: present }

    context 'before confirm donate' do
      it { expect(user.received?(present)).to eq(false) }
    end

    context 'after confirm donate' do
      before { gift.pay! }

      it { expect(user.received?(present)).to eq(true) }
    end
  end
end