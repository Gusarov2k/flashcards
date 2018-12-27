require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  include LogInHelper
  describe 'when not authorization' do
    context 'when links' do
      it 'login in' do
        visit log_in_path
        expect(page).to have_content('Log In')
      end

      it 'sign up' do
        visit sign_up_path
        expect(page).to have_content('New user')
      end

      it 'text about need authorization' do
        visit root_path
        expect(page).to have_content('Please login first.')
      end

      it 'email is incorrect' do
        visit log_in_path
        within('form') do
          fill_in 'Email', with: 'yea@ya.ru'
        end
        click_button 'Log In'
        expect(page).to have_content('E-mail and/or password is incorrect.')
      end
    end
  end

  describe 'validates' do
    let(:user) { build(:user) }

    before do
      visit sign_up_path
    end

    context 'when fails' do
      it 'name blank' do
        user.name = nil
        click_button 'Register'
        expect(page).to have_content('Name can\'t be blank')
      end
      it 'name short' do
        user.name = 'sa'
        click_button 'Register'
        expect(page).to have_content('Name is too short (minimum is 2 characters)')
      end

      it 'email blank' do
        user.email = nil
        click_button 'Register'
        expect(page).to have_content('Email can\'t be blank')
      end

      it 'email don\'t contains @ and .' do
        user.email = 'dafeerue'
        click_button 'Register'
        expect(page).to have_content('Email is invalid')
      end

      it 'password blank' do
        user.password = nil
        click_button 'Register'
        expect(page).to have_content('Password can\'t be blank')
      end

      it 'password short' do
        user.password = '12345'
        click_button 'Register'
        expect(page).to have_content('Password is too short (minimum is 5 characters)')
      end

      it 'password_confirmation blank' do
        within('form') do
          fill_in 'password', with: nil
        end
        click_button 'Register'
        expect(page).to have_content('Password confirmation can\'t be blank')
      end

      it 'password not equal password_confirmation' do
        within('form') do
          fill_in 'password', with: 12_345
          fill_in 'password_confirmation', with: 1234
        end
        click_button 'Register'
        expect(page).to have_content('Password confirmation doesn\'t match Password')
      end
    end
  end

  describe 'user registration' do
    before do
      visit sign_up_path
    end

    context 'when successful' do
      it 'all fields are correct' do
        within('form') do
          fill_in 'Name', with: 'yand3'
          fill_in 'email', with: 'ers@ya.ru'
          fill_in 'password', with: '12345'
          fill_in 'password_confirmation', with: '12345'
        end
        click_button 'Register'
        expect(page).to have_content('Welcome!')
      end
    end
  end

  describe 'update user' do
    let(:user) { create(:user) }

    before do
      log_in(user.email, 'secret', 'Log In')
    end

<<<<<<< HEAD
    context 'when successful' do
=======

    context 'when successful' do

>>>>>>> 008821e... add tests
      it 'update name and return text message' do
        visit edit_user_path(user)
        within('form') do
          fill_in 'Name', with: 'ivan2'
        end
        click_button 'Register'
        expect(page).to have_content('User was successfully updated.')
      end

<<<<<<< HEAD
=======

>>>>>>> 008821e... add tests
      it 'update email and return text message' do
        visit edit_user_path(user)
        within('form') do
          fill_in 'email', with: 'ivan@mail.ru'
        end
        click_button 'Register'
        expect(page).to have_content('User was successfully updated.')
      end
    end

    context 'when fail' do
      it 'empty email' do
        visit edit_user_path(user)
        within('form') do
          fill_in 'email', with: ''
        end
        click_button 'Register'
        expect(page).to have_content('Email can\'t be blank')
      end
    end
  end

  describe 'exit' do
    let(:user) { create(:user) }

    before do
      log_in(user.email, 'secret', 'Log In')
    end

    it do
      click_link 'Log Out'
      expect(page).to have_content('See you!')
    end
  end
end
