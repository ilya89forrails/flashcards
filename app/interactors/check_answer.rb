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

  def correct_answer(card)
    new_rating = ((card.rating.to_f / 3).ceil + 1) * 3.to_i
    new_rating = 15 if new_rating > 15
    context.card.update(rating: new_rating, review_date: leitner(new_rating))
    'You are right!'
  end

  def incorrect_answer(card)
    new_rating = card.rating - 1
    new_rating = 1 if new_rating % 3 == 0
    context.card.update(rating: new_rating, review_date: leitner(new_rating))
    "Wrong! '#{card.translated_text}' was translated as '#{card.original_text}'"
  end

  def leitner(rating)
    case rating
    when 1..3
      12.hours.since
    when 3..6
      3.days.since
    when 6..9
      1.week.since
    when 9..12
      2.week.since
    when 12..15
      1.month.since
    else
      1.month.since
    end
  end
end
