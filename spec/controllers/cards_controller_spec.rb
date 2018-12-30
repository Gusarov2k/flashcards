require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  describe 'index' do
    it 'returns index page' do
      get :index
      expect(response).to be_success
    end
  end
end
