every 1.day, at: '11:30 am' do
  runner 'CardMailer.cards_for_review.deliver_now'
end
