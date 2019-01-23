require 'rails_helper'

RSpec.describe Pack, type: :model do
  let(:pack) { build(:pack) }

  describe 'associations' do
    it { is_expected.to have_many(:cards) }
  end

  describe 'validations' do
    context 'when pack valid' do
      it { expect(pack).to be_valid }
    end

    context 'when pack invalid' do
      it 'name blank' do
        pack.name = nil
        expect(pack).not_to be_valid
      end
    end
  end
end
