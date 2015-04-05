require 'rails_helper'

RSpec.describe 'Gifts', type: :request do
  describe 'fitctions index page' do
    let!(:fiction) { FactoryGirl.create :fiction, title: 'First fiction' }

    before { visit fictions_path }

    it 'generate modal div', js: true do
      click_link 'buy'
      expect(page).to have_selector('a', text: 'Khayat')
    end
  end
end
