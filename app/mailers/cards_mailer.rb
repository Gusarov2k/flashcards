class CardsMailer < ApplicationMailer
  def reminder_of_cards(user)
    @user = user if user.current_pack
    @card = user.current_pack.cards.ready_for_review
    mail(to: user.email, subject: 'you have cards to check')
  end
end
