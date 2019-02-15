require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:pack) { create(:pack) }
  let(:card) { build(:card, pack_id: pack.id) }

  describe 'associations' do
    it { is_expected.to belong_to(:pack) }
  end

  describe 'validations' do
    context 'when card valid' do
      it { expect(card).to be_valid }
    end

    context 'when card invalid' do
      it 'original_text blank' do
        card.original_text = nil
        expect(card).not_to be_valid
      end
      it 'translated_text blank' do
        card.translated_text = nil
        expect(card).not_to be_valid
      end
    end

    context 'when text check' do
      it 'be valid original_text' do
        card.original_text = 'Дом'
        card.save
        expect(card.original_text).to eq('дом')
      end

      it 'be valid translated_text' do
        card.translated_text = 'ДоМ'
        card.save
        expect(card.translated_text).to eq('дом')
      end
    end

    it 'when text not valid' do
      card.translated_text = 'дом'
      card.original_text = 'дом'
      expect(card).not_to be_valid
    end
  end

  describe '#check_word' do
    let(:card) { build(:card, original_text: 'hause') }

    context 'when word valid' do
      it { expect(card.check_word('Hause')).to be_truthy }
      it { expect(card.check_word('  HausE ')).to be_truthy }
      it { expect(card.check_word('dom')).not_to be_truthy }
    end

    context 'when word not valid' do
      it { expect(card.check_word('')).not_to be_truthy }
    end
  end
end
