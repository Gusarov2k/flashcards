require 'rails_helper'

RSpec.describe 'Packs', type: :feature do
  include LogInHelper
  let(:user) { create(:user) }

  before do
    log_in(user.email, 'secret', 'Log In')
  end

  describe 'pack creation' do
    before do
      visit new_pack_path
    end

    context 'when successful' do
      it 'create pack' do
        within('form') do
          fill_in 'Name for pack', with: 'second'
        end

        click_button 'Create'
        expect(page).to have_content('name' && 'second')
      end
    end

    context 'when false' do
      it 'name blank' do
        within('form') do
          fill_in 'Name for pack', with: ''
        end
        click_button 'Create'
        expect(page).to have_content('Name can\'t be blank')
      end
    end
  end

  describe 'update pack' do
    let(:pack) { create(:pack) }

    before do
      visit edit_pack_path(pack)
    end

    context 'when true' do
      it 'change name' do
        within('form') do
          fill_in 'Name for pack', with: 'Second'
        end
        click_button 'Create'
        expect(page).to have_content('Second')
      end
    end

    context 'when fails' do
      it 'name blank' do
        within('form') do
          fill_in 'Name for pack', with: ''
        end
        click_button 'Create'
        expect(page).to have_content('Name can\'t be blank')
      end
    end
  end

  describe 'destroy pack' do
    let!(:pack) { create(:pack, user_id: user.id) }

    before do
      visit packs_path(pack)
    end

    it 'delete pack' do
      expect { click_link 'Delete', href: "/packs/#{pack.id}" }.to change(Pack, :count).by(-1)
    end
  end

  describe 'current pack' do
    let!(:pack) { create(:pack, user_id: user.id) }

    before do
      visit packs_path
    end

    it 'select the current pack' do
      click_link 'current', href: "/packs/#{pack.id}/current"
      expect(User.last.current_pack_id).to eq(pack.id)
    end
  end
end
