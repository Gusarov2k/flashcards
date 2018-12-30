require 'rails_helper'
include Sorcery::TestHelpers::Rails::Integration
include Sorcery::TestHelpers::Rails::Controller

RSpec.describe CardsController, type: :controller do
  before do
    create(:user)
    login_user('whatever@whatever.com', 'secret')
  end

  describe 'index' do
    it 'returns index page' do
      get :index
      expect(response).to be_success
    end
  end
end
