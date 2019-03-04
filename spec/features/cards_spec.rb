require 'rails_helper'

RSpec.describe 'Cards', type: :feature do
  include LogInHelper
  let(:user) { create(:user) }
  let!(:pack) { create(:pack, user_id: user.id) }

  before do
    log_in(user.email, 'secret', 'Log In')
  end

  describe 'card creation' do
    context 'when successful' do
      it 'create card' do
        visit new_card_path
        within('form') do
          fill_in 'Оригинальный текст', with: 'ace'
          fill_in 'Перевод текста', with: 'race'
          select 'first', from: 'card[pack_id]'
        end
        click_button 'Create'
        expect(page).to have_content('Перевод')
      end
    end

    describe 'card creation with image' do
      before do
        body_file = File.open(File.expand_path('./spec/support/logo_image.jpg'))
        stub_request(:get, 'https://www.thedomainofmyimage.com/image/test.jpg').to_return(body: body_file, status: 200)
      end

      it 'image from url' do
        visit new_card_path
        within('form') do
          fill_in 'Оригинальный текст', with: 'trace'
          fill_in 'Перевод текста', with: 'race'
          fill_in 'image from url', with: 'https://www.thedomainofmyimage.com/image/test.jpg'
          select 'first', from: 'card[pack_id]'
        end
        click_button 'Create'
        expect(page).to have_content('trace')
      end
    end

    context 'when fails' do
      it 'compare words ace with ace and return text message' do
        visit new_card_path
        within('form') do
          fill_in 'Оригинальный текст', with: 'ace'
          fill_in 'Перевод текста', with: 'ace'
          select 'first', from: 'card[pack_id]'
        end
        click_button 'Create'
        expect(page).to have_content('Original text Original text can\'t be translated')
      end

      it 'compare words ace with AcE and return text message' do
        visit new_card_path
        within('form') do
          fill_in 'Оригинальный текст', with: 'ace'
          fill_in 'Перевод текста', with: 'AcE'
          select 'first', from: 'card[pack_id]'
        end
        click_button 'Create'
        expect(page).to have_content('Original text Original text can\'t be translated')
      end

      it 'compare words aCe with AcE and return text message' do
        visit new_card_path
        within('form') do
          fill_in 'Оригинальный текст', with: 'aCe'
          fill_in 'Перевод текста', with: 'AcE'
          select 'first', from: 'card[pack_id]'
        end
        click_button 'Create'
        expect(page).to have_content('Original text Original text can\'t be translated')
      end
    end
  end

  describe 'card update' do
    let(:card) { create(:card, pack_id: pack.id) }

    before do
      visit edit_card_path(card)
    end

    context 'when successful' do
      it 'update data and return text message' do
        within('form') do
          fill_in 'Оригинальный текст', with: 'gnom'
          fill_in 'Перевод текста', with: 'guru'
          select 'first', from: 'card[pack_id]'
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

  describe 'destroy card', type: :controller do
    context 'when successful' do
      let!(:card) do
        create(:card, original_text: 'word',
                      translated_text: 'other',
                      pack_id: pack.id)
      end

      it 'delete card' do
        visit cards_path
        expect { click_link 'Delete', href: "/cards/#{card.id}" }.to change(Card, :count).by(-1)
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
    include FormHelper
    include ActiveSupport::Testing::TimeHelpers
    let!(:pack) { create(:pack, user_id: user.id) }
    let!(:card) { create(:card, pack_id: pack.id) }

    before do
      user.update(current_pack_id: pack.id)
      visit root_path
    end

    context 'when correct' do
      it 'card will have first box' do
        check_form
        expect(card.box).to equal(1)
      end

      it 'card will add 12 hours for first box' do
        check_form
        expect(card.review_date).to be_within(1.second).of(Time.zone.now + 12.hours)
      end

      it 'card will have second box' do
        check_form(1)
        expect(card.box).to equal(2)
      end

      it 'card will add 3 days for second box' do
        check_form(1)
        expect(card.review_date).to be_within(1.second).of(Time.zone.now + 3.days)
      end

      it 'card will have 3 box' do
        check_form(2)
        expect(card.box).to equal(3)
      end

      it 'card will add 7 days for 3 box' do
        check_form(2)
        expect(card.review_date).to be_within(1.second).of(Time.zone.now + 7.days)
      end

      it 'card will have 4 box' do
        check_form(3)
        expect(card.box).to equal(4)
      end

      it 'card will add 14 days for 4 box' do
        check_form(3)
        expect(card.review_date).to be_within(1.second).of(Time.zone.now + 14.days)
      end

      it 'card will have 5 box' do
        check_form(4)
        expect(card.box).to equal(5)
      end

      it 'card will add 1 month for 5 box' do
        check_form(4)
        expect(card.review_date).to be_within(1.second).of(Time.zone.now + 1.month)
      end

      it 'card had box 5 and add 1 month' do
        check_form(5)
        expect(card.review_date).to be_within(1.second).of(Time.zone.now + 1.month)
      end

      it 'the word is guessed without errors' do
        within('form') do
          fill_in 'check[user_text]', with: 'home'
        end
        click_button 'Save Check'
        expect(page).to have_content "You have guessed the word!"
      end

      it 'word contain 1 errors' do
        within('form') do
          fill_in 'check[user_text]', with: 'hom'
        end
        click_button 'Save Check'
        expect(page).to have_content "Original text: #{card.original_text}"
      end

      it 'word contain 2 errors' do
        within('form') do
          fill_in 'check[user_text]', with: 'ho'
        end
        click_button 'Save Check'
        expect(page).to have_content "Original text: #{card.original_text}"
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

      it 'first unsuccessful guessing attempt' do
        within('form') do
          fill_in 'check[user_text]', with: 'rest'
        end
        click_button 'Save Check'
        card.reload
        expect(card.guessing).to equal(1)
      end

      it 'incorrectly guessed 3 times and moving the card to the first box' do
        card.guessing = 3
        card.box = 4
        card.save
        within('form') do
          fill_in 'check[user_text]', with: 'reses'
        end
        click_button 'Save Check'
        card.reload
        expect(card.box).to equal(1)
      end

      it 'incorrectly guessed 3 times and reset the guessing to 0' do
        card.guessing = 3
        card.save
        within('form') do
          fill_in 'check[user_text]', with: 'reses'
        end
        click_button 'Save Check'
        card.reload
        expect(card.guessing).to equal(0)
      end
    end
  end

  describe 'with image' do
    include CarrierWave::Test::Matchers

    let(:card) { create(:card, pack_id: pack.id) }

    before do
      card.update(review_date: ((Date.current - 1.day)).to_s)
      visit root_path
    end

    context 'when true' do
      it { expect(card.image).to be_format('JPEG') }
      it { expect(card.image).to have_dimensions(360, 360) }
    end
  end
end
