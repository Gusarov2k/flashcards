require 'rails_helper'

describe Card do
  it "opens courses page after login" do
      expect(page).to have_content "Текущие курсы"
    end

  it "saves item record in DB" do
    item = Card.create(...)
    Card.find(card.id).should_not be_nil
  end
end
