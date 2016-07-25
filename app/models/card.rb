class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  validate :same_words, on: :create

  before_save :add_days, on: :create

  scope :unreviewed, -> { where('review_date <= ?', Date.today) }

  def self.get_random
    offset(rand(unreviewed.count)).first
  end

  protected

  def add_days
    self.review_date = review_date + 3.days
  end

  def same_words
    if original_text.casecmp(translated_text.downcase).zero?
      errors.add(:translated_text, 'Translated text cannot equal original text')
    end
  end
end
