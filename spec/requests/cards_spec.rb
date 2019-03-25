require "rails_helper"

RSpec.describe "Cards wiev", type: :request do
  it 'Include word with en locale url' do
    get '/en/log_in', formats: 'json'
    expect(response.body).to include("Flashcards")
  end
end
