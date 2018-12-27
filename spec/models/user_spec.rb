require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:cards).dependent(:destroy) }
    it { is_expected.to have_many(:authentications).dependent(:destroy) }
  end

  describe 'validations' do
    let(:user) { build(:user) }

    context 'when user valid' do
      it { expect(user).to be_valid }
    end

    context 'when user invalid' do
      it 'name blank' do
        user.name = nil
        expect(user).not_to be_valid
      end
      it 'email blank' do
        user.email = nil
        expect(user).not_to be_valid
      end
    end
  end
end
