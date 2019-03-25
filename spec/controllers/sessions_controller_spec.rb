require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  render_views

  describe 'internationalization' do
    context 'when true' do
      it 'browser set ru locale' do
        request.env['HTTP_ACCEPT_LANGUAGE'] = 'ru-RU'
        get :new, formats: 'json'
        expect(response.body).to include('Флешкарточки')
      end

      it 'browser set en locale' do
        request.env['HTTP_ACCEPT_LANGUAGE'] = 'en-EN'
        get :new, formats: 'json'
        expect(response.body).to include('Flashcards')
      end
    end
  end
end
