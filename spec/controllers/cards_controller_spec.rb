require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:user) { build(:user) }

  describe 'index' do
    it 'returns index page' do
      login_user(user)
      get :index
      expect(response).to be_success
    end
  end
end
