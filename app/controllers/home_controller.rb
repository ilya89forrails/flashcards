class HomeController < ApplicationController
  def index
    if current_user
      if current_user.current_deck_id?
        @card = current_user.cards.get_random_from_current_deck(current_user)
      else
        @card = current_user.cards.get_random
      end
    end
  end

  def check_answer
    @card = Card.find(params[:id])
    result = CheckAnswer.call(card: @card, answer: params[:answer])


    respond_to do |format|
      format.html
      format.js
    end

    redirect_to root_path
  end
end
