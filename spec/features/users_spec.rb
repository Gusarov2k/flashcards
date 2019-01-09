require 'rails_helper'

RSpec.describe 'Cards', type: :feature do
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
          fill_in 'password', with: 12345
          fill_in 'password_confirmation', with: 1234
        end
        click_button 'Register'
        expect(page).to have_content('Password confirmation doesn\'t match Password')
      end
    end
  end
end
