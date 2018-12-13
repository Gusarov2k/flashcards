class FlashCardsController < ApplicationController
  before_action :set_flash_card, only: %i[word_comparison]

  def index
    @card = Card.all.third_days_ago.sample(1)
  end

  def word_comparison
    if @card.check_word(flash_cards_params[:user_text])
      @card.add_therd_days
      flash[:flash_message] = 'You have guessed the word!'
      redirect_to '/'
    else
      flash.now[:flash_message] = 'Your word is not equal to the original'
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
