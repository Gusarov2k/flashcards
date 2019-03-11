require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
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

  describe 'scope with_unreviewed_cards' do
    let(:user) { create(:user) }
    let(:second_user) { create(:user, name: 'second', email: 'second@cer.ru') }
    let(:pack_second) { create(:pack, name: 'second', user: user) }
    let(:pack_third) { create(:pack, name: 'third', user: second_user) }
    let(:card_second) { create(:card, original_text: 'second', pack: pack_second) }
    let(:card_third) { create(:card, original_text: 'third', pack: pack_third) }

    before do
      card_second.pack.user.update(current_pack_id: card_second.pack.id)
      card_third.pack.user.update(current_pack_id: card_third.pack.id)
      card_second.update(review_date: Time.zone.now - 1.day)
      card_third.update(review_date: Time.zone.now + 1.minute)
    end

    context 'when true' do
      it 'return user with card for review' do
        expect(User.with_unreviewed_cards).to match_array(card_second.pack.user)
      end
    end

    context 'when false' do
      it 'user with card not for review' do
        expect(User.with_unreviewed_cards).not_to match_array(card_third.pack.user)
      end
    end
  end
end
