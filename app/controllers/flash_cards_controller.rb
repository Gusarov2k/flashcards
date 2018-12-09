class FlashCardsController < ApplicationController
  def index
    @cards = Card.all.third_days_ago.sample(1)
    @user_value = UserValidate.new
  end

  def update; end

  def create
    @user_value = UserValidate.new(user_validate_params)

    if @user_value
      redirect_to cards_path
    else
      flash.now[:error] = "Can't connect..."
    end
  end

  private

  def user_validate_params
    params.require(:user_validate).permit(:user_text, :original_text)
  end
end
