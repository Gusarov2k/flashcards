class CardsController < ApplicationController
  before_action :set_card, only: %i[show edit update destroy word_comparison]
  before_action :find_all_packs, only: %i[index new create edit update]

  def index
    @cards = Card.all_cards(@packs)
  end

  def show; end

  def new
    @card = Card.new
  end

  def edit; end

  def create
    @packs = current_user.packs
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
    @card = if current_user.current_pack
              current_user.current_pack.cards.ready_for_review.random.first
            else
              flash[:flash_message] = 'Haven\'t current pack'
              render 'random'
            end
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

  def find_all_packs
    @packs = current_user.packs
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text,
                                 :translated_text,
                                 :review_date,
                                 :image,
                                 :image_cache,
                                 :remote_image_url,
                                 :pack_id)
  end
end
