class CardMailer < ApplicationMailer
  def cards_for_review
    @users = User.with_unreviewed_cards
    @users.each do |user|
      @user = user
      mail(to: @user.email, subject: 'You have cards for review')
    end
  end
end
