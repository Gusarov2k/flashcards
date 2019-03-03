class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    @user = user
    CardsMailer.reminder_of_cards(@user).deliver_later
  end
end
