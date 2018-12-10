class FlashCardsController < ApplicationController
  def index
    @cards = Card.all.third_days_ago.sample(1)
    if request.post?
      @user_value = UserValidate.new(user_validate_params)
      redirect_to cards_path if @user_value.check_word
    else
      @user_value = UserValidate.new
    end
  end

  private

  def user_validate_params
    params.require(:user_validate).permit(:user_text, :original_text)
  end
end
