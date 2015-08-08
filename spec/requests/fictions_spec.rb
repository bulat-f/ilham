require 'rails_helper'

RSpec.describe 'Fictions', type: :request do
  let!(:fiction) { FactoryGirl.create :fiction }
  let!(:user)    { FactoryGirl.create :user }

  describe 'index page' do
    context 'user signed in' do
      before do
        login_as user, scope: :user
        visit fictions_path
      end

      it 'when click more' do
        click_link I18n.t('fictions.actions.more')
        expect(current_path).to eq(fiction_path(fiction))
      end

      it 'generate modal div', js: true do
        click_button I18n.t('fictions.actions.pay')
        expect(page).to have_css('h1#title', text: fiction.title)
      end
    end

    context 'user did not sign in' do
      before do
        visit fictions_path
      end

      it 'when click more' do
        click_link I18n.t('fictions.actions.more')
        expect(current_path).to eq(fiction_path(fiction))
      end

      it 'redirect sign in path for pay' do
        click_link I18n.t('fictions.actions.pay')
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end