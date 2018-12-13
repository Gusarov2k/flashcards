class FlashCardsController < ApplicationController
  before_action :set_flash_card, only: %i[word_comparison]

  def index
    @card = Card.all.third_days_ago.sample(1)
  end

  private

  def set_flash_card
    @card = Card.find(params[:card][:id])
  end
end
