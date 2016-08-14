class HomeController < ApplicationController
  def index
    @card = current_user.cards.get_random if current_user
  end

  def check_answer
    @card = Card.find(params[:id])
    result = CheckAnswer.call(card: @card, answer: params[:answer])
    flash[:notice] = result.message
    redirect_to root_path
  end
end
