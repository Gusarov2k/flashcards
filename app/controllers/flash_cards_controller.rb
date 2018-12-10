class FlashCardsController < ApplicationController
  def index
    @card = Card.all.third_days_ago.sample(1)
  end

  def update; end

  private

  def flash_cards_params
    params.require(:card).permit(:translated_text, :user_text)
  end
end
