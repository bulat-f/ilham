require 'rails_helper'

RSpec.describe 'Gifts', type: :request do
  describe 'fitctions index page' do
    let!(:fiction) { FactoryGirl.create :fiction, title: 'First fiction' }

    before { visit fiction_path(fiction) }

    it 'generate modal div', js: true do
      expect(page).to have_selector('h1', text: fiction.title)
    end
  end
end
