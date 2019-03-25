require 'rails_helper'

RSpec.describe 'Internationalization', type: :feature do
  describe 'Switch internationalization with links' do
    context 'when true' do
      it 'Set ru locale' do
        visit root_path
        click_link 'Russian'
        expect(page).to have_content('Флешкарточки')
      end

      it 'Set en locale' do
        visit root_path(locale: :ru)
        click_link 'English'
        expect(page).to have_content('Flashcards')
      end
    end
  end
end
