class CardsController < ApplicationController
  include CardsHelper

  before_action :set_deck
  before_action :set_card, only: [:edit, :show, :update, :destroy]

  def index
    @cards = @deck.cards.all
  end

  def new
    @card = @deck.cards.new
  end

  def edit
  end

  def show
  end

  def create
    @card = @deck.cards.new(card_params)
    @card.user_id = @deck.user_id
    @card.review_date = Date.today #+ 3.days
    CardsMailer.pending_cards_notification.deliver_now
    if @card.save
      redirect_to deck_path(@deck)
    else
      render 'new'
    end
  end

  def update
    @card.update(card_params)
    redirect_to deck_path(@deck)
  end

  def destroy
    @card.destroy
    redirect_to deck_path(@deck)
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :pic, :deck_id)
  end

  def set_deck
    @deck = current_user.decks.find(params[:deck_id])
  end

  def set_card
    @card = @deck.cards.find(params[:id])
  end
end
