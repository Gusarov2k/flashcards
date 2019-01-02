class CardsController < ApplicationController
  before_action :set_card, only: %i[show edit update destroy word_comparison]

  def index
    @cards = Card.all
  end

  def show; end

  def new
    @card = Card.new
  end

  def edit; end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to @card
    else
      render :new
    end
  end

  def update
    if @card.update(card_params)
      redirect_to @card
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  def random
    @card = Card.ready_for_review.random.first
  end

  def word_comparison
    if @card.check_word(params[:check][:user_text])
      @card.recheck_date
      flash[:flash_message] = 'You have guessed the word!'
      redirect_to root_path
    else
      flash.now[:flash_message] = 'Your word is not equal to the original'
      render 'random'
    end
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :user_id)
  end
end
