require 'rails_helper'

RSpec.feature "Cards", type: :feature do
  context 'create new card' do
    scenario 'should be successful' do
      visit new_card_path
      within('form') do
        fill_in 'Оригинальный текст', with: 'ace'
        fill_in 'Перевод текста', with: 'race'
      end
      click_button 'Create'
      expect(page).to have_content('Перевод')
    end

    scenario 'should fail' do
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
    before(:each) do
      visit edit_card_path(card)
    end
    scenario 'should be successful' do
      within('form') do
        fill_in 'Оригинальный текст', with: 'gnom'
        fill_in 'Перевод текста', with: 'guru'
      end
      click_button 'Create'
      expect(page).to have_content('guru')
    end

    scenario 'should fail' do
      within('form') do
        fill_in 'Оригинальный текст', with: ''
      end
      click_button 'Create'
      expect(page).to have_content('be blank')
    end

  end

  context 'destroy card' do
    scenario 'should be successful' do
      card = Card.create(original_text: 'word', translated_text: 'other')
      visit cards_path
      expect {click_link 'Delete'}.to change(Card, :count).by(-1)
    end
  end

end
