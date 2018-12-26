require 'rails_helper'

RSpec.describe 'Cards', type: :feature do
  describe 'card creation' do
    context 'when successful' do
      it 'create card' do
        visit new_card_path
        within('form') do
          fill_in 'Оригинальный текст', with: 'ace'
          fill_in 'Перевод текста', with: 'race'
        end
        click_button 'Create'
        expect(page).to have_content('Перевод')
      end
    end

    context 'when fails' do
      it 'compare words ace with ace and return text message' do
        visit new_card_path
        within('form') do
          fill_in 'Оригинальный текст', with: 'ace'
          fill_in 'Перевод текста', with: 'ace'
        end
        click_button 'Create'
        expect(page).to have_content('Original text Original text can\'t be translated')
      end

      it 'compare words ace with AcE and return text message' do
        visit new_card_path
        within('form') do
          fill_in 'Оригинальный текст', with: 'ace'
          fill_in 'Перевод текста', with: 'AcE'
        end
        click_button 'Create'
        expect(page).to have_content('Original text Original text can\'t be translated')
      end

      it 'compare words aCe with AcE and return text message' do
        visit new_card_path
        within('form') do
          fill_in 'Оригинальный текст', with: 'aCe'
          fill_in 'Перевод текста', with: 'AcE'
        end
        click_button 'Create'
        expect(page).to have_content('Original text Original text can\'t be translated')
      end
    end
  end

  describe 'card update' do
    let(:card) { create(:card) }

    before do
      visit edit_card_path(card)
    end

    context 'when successful' do
      it 'update data and return text message' do
        within('form') do
          fill_in 'Оригинальный текст', with: 'gnom'
          fill_in 'Перевод текста', with: 'guru'
        end
        click_button 'Create'
        expect(page).to have_content('guru')
      end
    end

    context 'when fails' do
      it 'compare word with empty line and return message' do
        within('form') do
          fill_in 'Оригинальный текст', with: ''
        end
        click_button 'Create'
        expect(page).to have_content('be blank')
      end
    end
  end

  describe 'destroy card' do
    context 'when successful' do
      let(:card) { create(:card) }

      it 'delete card' do
        card.original_text = 'word'
        card.translated_text = 'other'
        visit cards_path
        expect { click_link 'Delete' }.to change(Card, :count).by(-1)
      end
    end
  end

  describe '#check_word' do
    context 'when word not correct' do
      it 'compare words дом with ДоМ and return text message' do
        visit new_card_path
        within('form') do
          fill_in 'Оригинальный текст', with: 'дом'
          fill_in 'Перевод текста', with: 'ДоМ'
        end
        click_button 'Create'
        expect(page).to have_content('Original text can\'t be translated')
      end

      it 'compare words дом with Дом and return text message' do
        visit new_card_path
        within('form') do
          fill_in 'Оригинальный текст', with: 'дом'
          fill_in 'Перевод текста', with: 'Дом'
        end
        click_button 'Create'
        expect(page).to have_content('Original text can\'t be translated')
      end
    end
  end

  describe '#word_comparison' do
    let(:card) { create(:card) }

    before do
      card.update(review_date: ((Date.current - 1.day)).to_s)
      visit root_path
    end

    context 'when correct' do
      it 'compare word home and return text message' do
        within('form') do
          fill_in 'check[user_text]', with: 'home'
        end
        click_button 'Save Check'
        expect(page).to have_content 'You have guessed the word!'
      end

      it 'compare word HomE and return text message' do
        within('form') do
          fill_in 'check[user_text]', with: 'HomE'
        end
        click_button 'Save Check'
        expect(page).to have_content 'You have guessed the word!'
      end
    end

    context 'when not correct' do
      it 'compare word RoR and return text message' do
        within('form') do
          fill_in 'check[user_text]', with: 'RoR'
        end
        click_button 'Save Check'
        expect(page).to have_content 'Your word is not equal to the original'
      end

      it 'compare empty line and return text message' do
        within('form') do
          fill_in 'check[user_text]', with: ''
        end
        click_button 'Save Check'
        expect(page).to have_content 'Your word is not equal to the original'
      end
    end
  end
end
