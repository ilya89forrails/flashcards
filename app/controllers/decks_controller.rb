class DecksController < ApplicationController
  include CardsHelper

  def index
    @decks = current_user.decks.all
  end

  def new
    @deck = current_user.decks.new
  end

  def edit
    @deck = current_user.decks.find(params[:id])
  end

  def show
    @deck = current_user.decks.find(params[:id])
  end

  def create
    @deck = Deck.new(card_params)
    @deck.user_id = current_user.id

    if @deck.save
      redirect_to decks_path
    else
      render 'new'
    end
  end

  def update
    @deck = Deck.find(params[:id])
    @deck.update(deck_params)
    redirect_to deck_path(@deck)
  end

  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy
    redirect_to decks_path
  end

  def make_current
    current_user.update(current_deck_id: params[:id])
    redirect_to decks_path
  end

  private

  def card_params
    params.require(:deck).permit(:title, :user_id)
  end
end
