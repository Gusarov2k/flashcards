class FlashCardsController < ApplicationController
  def index
    @cards = Card.all.third_days_ago
  end
end
