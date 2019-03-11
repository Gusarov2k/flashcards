require 'rails_helper'

RSpec.describe CardMailer, type: :mailer do
  describe 'cards_for_review' do
    let(:user) { create(:user, email: 'test@mail.com') }
    let(:card_second) { create(:card, original_text: 'second', pack: pack_second) }
    let(:pack_second) { create(:pack, name: 'second', user: user) }
    let(:mail) { CardMailer.cards_for_review.deliver_now }

    before do
      card_second.pack.user.update(current_pack_id: card_second.pack.id)
      card_second.update(review_date: Time.zone.now - 1.day)
    end

    context 'when true' do
      it 'send mail to user.email' do
        expect(mail.to).to eq([user.email])
      end

      it 'the text of the letter header' do
        expect(mail.subject).to eq('You have cards for review')
      end

      it 'presence of user name in letter' do
        expect(mail.body.encoded).to match(user.name)
      end

      it 'presence of link to root url' do
        expect(mail.body.encoded).to match("http://localhost:3000/")
      end
    end
  end
end
