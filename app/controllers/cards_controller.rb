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
    @levenshtein = @card.levenshtein(params[:check][:user_text])
    if @levenshtein <= 2
      if @levenshtein.zero?
        flash[:flash_message] = 'You have guessed the word!'
      else
        flash[:flash_message] = 'Your are guessing but: '
        flash[:original_message] = "Original text: #{@card.original_text}"
        flash[:user_message] = "your variant: #{params[:check][:user_text]}"
      end
      @card.set_review_date_and_box
      redirect_to root_path
    else
      flash[:flash_message] = 'Your word is not equal to the original'
      @card.check_bad_guessing
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
