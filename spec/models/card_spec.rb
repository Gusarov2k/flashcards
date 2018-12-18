require 'rails_helper'

RSpec.describe Card, type: :model do
  context 'validation tests' do
    let(:card) { build(:card) }
    it 'all content blank' do
      card.valid?
      expect(card.errors.full_messages).to include('Original text can\'t be blank')
    end
    it 'ensures original_text presence' do
      card.original_text = nil
      expect(card.errors.full_messages).to include('text can\'t be blank')
    end

    it 'ensures translated_text presence' do
      card.translated_text = nil
      expect(card).to eq(false)
    end

    it 'saves successfully' do
      card = Card.new(original_text: 'First', translated_text: 'Last').save
      expect(card).to eq(true)
    end
  end
end
