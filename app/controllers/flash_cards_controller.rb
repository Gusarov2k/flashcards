class FlashCardsController < ApplicationController
  def index
    @cards = Card.all.third_days_ago
  end

  def update; end

  private

  def flash_cards_params
    params.require(:card).permit(:translated_text)
  end
end
