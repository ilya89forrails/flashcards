module CardsHelper

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end


end
