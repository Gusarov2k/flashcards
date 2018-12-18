require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  context 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_success # response.success?
    end
  end

  context 'GET #show' do
    it 'returns a success response' do
      card = Card.create!(original_text: 'First', translated_text: 'Last')
      get :show, params: { id: card.to_param }
      expect(response).to be_success
    end
  end
end
