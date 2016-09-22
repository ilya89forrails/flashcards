class Supermemo
  def self.recalculate_date(card)
    additional_time =
      case card.repetition
      when 1
        1.day
      when 2
        6.days
      else
        ((card.repetition - 1) * card.efactor).to_f.days
      end
    card.review_date = card.review_date + additional_time
  end

  # def self.set_quality

  # end

  def self.set_efactor(efactor, quality)
    efactor += (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    if efactor < 1.3
      efactor = 1.3
    elsif efactor > 2.5
      efactor = 2.5
    end
    efactor
  end
end
