class CheckAnswer
  include Interactor

  def call
    if context.answer == context.card.original_text
      context.message = correct_answer(context.card)
      context.card.save
    else
      context.message = incorrect_answer(context.card)
    end
  end

  private

  def correct_answer(_card)
    'You are right!'
  end

  def incorrect_answer(card)
    "Wrong! '#{card.translated_text}' was translated as '#{card.original_text}'"
  end
end
