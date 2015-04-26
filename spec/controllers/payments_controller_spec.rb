require 'rails_helper'

describe PaymentsController do
  let(:user)       { FactoryGirl.create :user }
  let(:other_user) { FactoryGirl.create :user }
  let(:fiction)    { FactoryGirl.create :fiction, price: 1000 }
  let(:purchase)   { FactoryGirl.create :purchase, reader: user, fiction: fiction }
  let(:gift)       { user.given_gifts.create presentee: other_user, present: fiction }

  describe '#create' do
    let(:params)   { { payment: { payable_id: purchase.id, payable_type: 'Purchase' } } }

    describe 'when user do not signed in' do
      it 'should not change payments count' do
        expect{ post :create, params }.not_to change(Payment, :count)
      end
    end

    describe 'when user signed in' do
      before do
        sign_in user
      end

      context 'and purchase not exist' do
        let(:next_purchase) { FactoryGirl.create :purchase, reader: user }
        let(:next_params)   { { payment: { payable_id: next_purchase.id,
                                           payable_type: 'Purchase' } } }
        before { next_purchase.destroy }
        it 'should not change payment count' do
          expect{ post :create, next_params }.not_to change(Payment, :count)
        end
      end

      context 'and purchase exist' do
        context 'with payed status' do
          before { purchase.pay! }

          it 'should not change payments count' do
            expect{ post :create, params }.not_to change(Payment, :count)
          end
        end

        context 'without payed status' do
          it 'should change payments count' do
            expect{ post :create, params }.to change(Payment, :count)
          end
        end

        context 'payment sum' do
          before { post :create, params }
          it { expect(Payment.last.sum).to eq(fiction.price) }
        end
      end

      describe 'and the user is not the owner of the' do
        context 'purchase' do
          let(:alien_purchase) { FactoryGirl.create :purchase }
          let(:alien_params)   { { payment: { payable_id: alien_purchase.id,
                                              payable_type: 'Purchase' } } }

          it 'should not change payments count' do
            expect{ post :create, alien_params }.not_to change(Payment, :count)
          end
        end

        context 'gift' do
          let(:alien_gift)   { FactoryGirl.create :gift }
          let(:alien_params) { { payment: { payable_id: alien_gift.id,
                                            payable_type: 'Gift' } } }

          it 'should not change payments count' do
            expect{ post :create, alien_params }.not_to change(Payment, :count)
          end
        end
      end
    end
  end

  describe '#confirm' do
    let(:purchase_payment) { FactoryGirl.create :purchase_payment,
                             payable: purchase }

    let(:gift_payment)     { FactoryGirl.create :gift_payment,
                             payable: gift }

    describe 'status is pay' do
      let(:purchase_params) { { method: 'pay', params:
                                { account: purchase_payment.id } } }

      let(:gift_params)     { { method: 'pay', params:
                                { account: gift_payment.id } } }

      let(:json)            { { result: { message: 'Success' } }.to_json }

      context 'user buys the fiction' do
        before do
          get :confirm, purchase_params
        end

        it { expect(response.body).to eq(json) }
        it { expect(user.bought?(fiction)).to eql(true) }
      end

      context 'user gives the fiction' do
        before do
          get :confirm, gift_params
          gift.reload
        end

        it { expect(response.body).to eq(json) }
        it { expect(user.bought?(fiction)).to eq(false) }
        it { expect(other_user.can_read?(fiction)).to eq(true) }
        it { expect(gift.paid?).to eq(true) }
      end
    end

    describe 'status is check' do
      let(:purchase_params) { { method: 'check', params:
                                { account: purchase_payment.id } } }

      let(:gift_params)     { { method: 'check', params:
                                { account: gift_payment.id } } }

      let(:json)            { { result: { message: 'Success' } }.to_json }

      context 'user buys the fiction' do
        before do
          get :confirm, purchase_params
        end

        it { expect(response.body).to eq(json) }
        it { expect(user.bought?(fiction)).to eql(false) }
      end

      context 'user gives the fiction' do
        before do
          get :confirm, gift_params
          gift.reload
        end

        it { expect(response.body).to eq(json) }
        it { expect(user.bought?(fiction)).to eq(false) }
        it { expect(other_user.can_read?(fiction)).to eq(false) }
        it { expect(gift.paid?).to eq(false) }
      end
    end
  end
end
