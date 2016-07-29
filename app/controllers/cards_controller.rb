class CardsController < ApplicationController
  include CardsHelper

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def edit
    @card = Card.find(params[:id])
  end

  def show
    @card = Card.find(params[:id])
  end

  def create
    @card = Card.new(card_params)
    #@card.review_date = Date.today
    if @card.save
      redirect_to card_path(@card)
    else
      render 'new'
    end
  end

  def update
    @card = Card.find(params[:id])
    @card.update(card_params)
    redirect_to card_path(@card)
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to cards_path
  end
end

def card_params
  params.require(:card).permit(:original_text, :translated_text, :review_date)
end
