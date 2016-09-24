class CheckAnswer
  include Interactor
  require 'damerau-levenshtein'
  require_relative '../services/supermemo.rb'

  def call
    if context.answer == context.card.original_text
      context.message = correct_answer(context.card)
    elsif mistype_check(context.answer, context.card.original_text)
      context.message = mistype_answer(context.answer, context.card)
    else
      context.message = incorrect_answer(context.card)
    end
  end

  private

  def check(card, quality)
    repetition = card.repetition + 1
    new_efactor = Supermemo.set_efactor(card.efactor, quality)
    new_review_date = Supermemo.recalculate_date(card)
    context.card.update(repetition: repetition, efactor: new_efactor, review_date: new_review_date)
  end

  def correct_answer(card)
    check(card, 5.0)
    'You are right!'
  end

  def incorrect_answer(card)
    check(card, 0.0)
    "Wrong! '#{card.translated_text}' was translated as '#{card.original_text}'"
  end

  def mistype_answer(answer, card)
    check(card, 3.0)
    "You are little misspelled. You answered #{answer}, and correct answer was #{card.original_text}"
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

  def mistype_check(answer, original)
    levenshtein(answer, original) <= acceptable_mistakes(original.length)
  end
end
