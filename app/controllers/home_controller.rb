class HomeController < ApplicationController
  def index
    @card = Card.get_random
  end

  def check_answer
    @card = Card.find(params[:id])
    if Card.check_answer(@card, params[:answer])
      correct_answer(@card)
      @card.save    
    else
      incorrect_answer(@card)
    end
    redirect_to root_path
  end

  private

  def correct_answer(_card)
    flash[:correct] = 'You are right!'
  end

  def incorrect_answer(card)
    flash[:incorrect] = "Wrong! '#{card.translated_text}' was translated as '#{card.original_text}'"
  end
end
