require 'rails_helper'

RSpec.describe "Cards", type: :feature do
  context 'create new card' do
    it 'is successful' do
      visit new_card_path
      within('form') do
        fill_in 'Оригинальный текст', with: 'ace'
        fill_in 'Перевод текста', with: 'race'
      end
      click_button 'Create'
      expect(page).to have_content('Перевод')
    end

    it 'fails' do
      visit new_card_path
      within('form') do
        fill_in 'Оригинальный текст', with: 'ace'
        fill_in 'Перевод текста', with: 'ace'
      end
      click_button 'Create'
      expect(page).to have_content('Original text Original text can\'t be translated')
    end
  end

  context 'update card' do
    let!(:card) { Card.create(original_text: 'word', translated_text: 'other') }

    before do
      visit edit_card_path(card)
    end

    it 'is successful' do
      within('form') do
        fill_in 'Оригинальный текст', with: 'gnom'
        fill_in 'Перевод текста', with: 'guru'
      end
      click_button 'Create'
      expect(page).to have_content('guru')
    end

    it 'fails' do
      within('form') do
        fill_in 'Оригинальный текст', with: ''
      end
      click_button 'Create'
      expect(page).to have_content('be blank')
    end
  end

  context 'destroy card' do
    it 'is successful' do
      card = Card.create(original_text: 'word', translated_text: 'other')
      visit cards_path
      expect { click_link 'Delete' }.to change(Card, :count).by(-1)
    end
  end
end
