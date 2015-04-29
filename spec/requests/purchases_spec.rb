require 'rails_helper'

RSpec.describe 'Purchases', :type => :request do
  let!(:user)    { FactoryGirl.create :user }
  let!(:fiction) { FactoryGirl.create :fiction }
  describe 'creating' do
    before do
      login_as user, scope: :user
      visit fictions_path
    end

    it 'when click buy button', js: true do
      click_button I18n.t('fictions.actions.pay')
      expect{ click_button I18n.t('fictions.actions.buy') }.to change(user.purchases, :count)
    end
  end
end
