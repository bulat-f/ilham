require 'rails_helper'

RSpec.describe 'Fictions', type: :request do
  let!(:fiction) { FactoryGirl.create :fiction }

  describe 'index page' do
    before { visit fictions_path }

    it 'when click more' do
      click_link I18n.t('fictions.action.more')
      expect(current_path).to eq(fiction_path(fiction))
    end

    it 'generate modal div', js: true do
      click_link I18n.t('fictions.action.pay')
      expect(page).to have_css('h1#title', text: fiction.title)
    end
  end
end
