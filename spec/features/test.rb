require 'rails_helper'

describe Card do
  it "opens courses page after login" do
    expect(page).to have_content "Текущие курсы"
  end

  it "saves item record in DB" do
    item = Card.create(original_text: 'resr', translated_text: 'gest')
    Card.find(item.id).should_not be_nil
  end
end
