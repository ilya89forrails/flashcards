class HomeController < ApplicationController
  def index
    @card = Card.get_random
  end

  def check_answer
    @card = Card.find(params[:id])
    result = CheckAnswer.call(card: @card, answer: params[:answer])
    flash[:notice] = result.message
    redirect_to root_path
  end
end
