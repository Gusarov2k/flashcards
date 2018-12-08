class FlashCardsController < ApplicationController
  def index
    @cards = Card.all.third_days_ago.sample(1)
  end

  def update; end

  def create
    if flash_cards_params_original == flash_cards_params_user
      redirect_to cards_path
    else
      render 'yt df'
    end
  end

  private

  def flash_cards_params_original
    params.require(:flash_cards_value).permit!(:translated_text)
  end

  def flash_cards_params_user
    params.require(:flash_cards_value).permit(:user_text)
  end
end
