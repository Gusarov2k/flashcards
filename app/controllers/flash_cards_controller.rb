class FlashCardsController < ApplicationController
  before_action :set_flash_card, only: %i[word_comparison]

  def index
    @card = Card.all.third_days_ago.sample(1)
  end

  def word_comparison
    if @card.check_word(flash_cards_params[:user_text])
      @card.add_therd_days
      redirect_to '/'
    else
      render :index
    end
  end

  private

  def set_flash_card
    @card = Card.find(params[:card][:id])
  end

  def flash_cards_params
    params.require(:card).permit(:translated_text, :original_text, :user_text)
  end
end
