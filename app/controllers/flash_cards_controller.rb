class FlashCardsController < ApplicationController
  def index
    @card = Card.select_line_created_earlier
  end
end
