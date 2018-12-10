class FlashCardsController < ApplicationController
  def index
    @card = Card.all.third_days_ago.sample(1)
  end

  def create
  end

  private

  def user_validate_params
    params.require(:user_validate).permit(:user_text, :original_text)
  end
end
