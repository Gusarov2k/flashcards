require "rails_helper"

RSpec.describe "Widget management", type: :request do
  it "creates a Widget" do
    get '/en/log_in', formats: 'json'
    expect(response.body).to include("Flashcards")
  end
end
