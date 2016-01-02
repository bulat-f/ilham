require 'rails_helper'

RSpec.describe 'Purchases', type: :request do
  let!(:user)    { FactoryGirl.create :user }
  let!(:fiction) { FactoryGirl.create :fiction }
  let(:buy_button) { I18n.t('fictions.actions.buy') }
  let(:pay_button) { I18n.t('fictions.actions.pay') }

  before do
    login_as user, scope: :user
  end

  describe 'creating' do
    before { visit fictions_path }
    context 'if it not exist' do
      before { click_button pay_button }
      context 'when click buy button' do
        it 'should change user purchases count', js: true do
          expect { click_button buy_button }.to change(user.purchases, :count)
        end

        it 'should redirect to new payment path', js: true do
          click_button buy_button
          expect(current_path).to eq(new_payment_path)
        end
      end
    end

    context 'if it exist' do
      let!(:purchase) { user.purchases.create fiction: fiction }

      context 'when click buy button' do
        before { click_button pay_button }

        context 'but user did not pay' do
          it 'should have buy button', js: true do
            expect(page).to have_button(buy_button)
          end
        end
      end
    end
  end

  describe 'after paid' do
    let!(:purchase) { user.purchases.create fiction: fiction }
    before do
      purchase.pay!
      visit fictions_path
    end

    it 'should not have pay button' do
      expect(page).not_to have_button(pay_button)
    end
  end
end
