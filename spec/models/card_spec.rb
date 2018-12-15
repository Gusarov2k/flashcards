require 'rails_helper'

RSpec.describe Card, type: :model do
  context 'validation tests' do
    it 'ensures original_text presence' do
      card = Card.new(translated_text: 'First').save
      expect(card).to eq(false)
    end

    it 'ensures translated_text presence' do
      card = Card.new(original_text: 'Last').save
      expect(card).to eq(false)
    end

    it 'should save successfully' do
      card = Card.new(original_text: 'First', translated_text: 'Last').save
      expect(card).to eq(true)
    end
  end
end
