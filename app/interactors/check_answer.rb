class CheckAnswer
  include Interactor
  require 'damerau-levenshtein'

  def call
    if context.answer == context.card.original_text
      context.message = correct_answer(context.card)
    elsif mistype_answer(context.answer, context.card.original_text)
      context.message = correct_answer(context.card)
      context.message = "You are little misspelled. You answered #{context.answer},
                         and correct answer was #{context.card.original_text}"
    else
      context.message = incorrect_answer(context.card)
    end
  end

  private

  def correct_answer(card)
    rating = card.rating + 1
    rating = 5 if rating > 5
    context.card.update(incorrect_count: 0, rating: rating, review_date: leitner(rating))
    'You are right!'
  end

  def incorrect_answer(card)
    incorrect_count = card.incorrect_count + 1
    rating = card.rating
    if incorrect_count == 3
      incorrect_count = 0
      rating = 1
    end
    context.card.update(incorrect_count: incorrect_count, rating: rating, review_date: leitner(rating))
    "Wrong! '#{card.translated_text}' was translated as '#{card.original_text}'"
  end

  def leitner(rating)
    case rating
    when 1
      12.hours.since
    when 2
      3.days.since
    when 3
      1.week.since
    when 4
      2.week.since
    when 5
      1.month.since
    else
      1.month.since
    end
  end

  def levenshtein(answer, original)
    dl = DamerauLevenshtein
    dl.distance(answer, original)
  end

  def acceptable_mistakes(length)
    case length
    when 1..4
      0
    when 5..7
      1
    else
      2
    end
  end

  def mistype_answer (answer, original)
    levenshtein(answer, original) <= acceptable_mistakes(original.length)
  end
end
