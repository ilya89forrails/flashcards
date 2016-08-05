class Card < ApplicationRecord
  #validates :original_text, :translated_text, :review_date, presence: true
  #validate :same_words, on: :create
  #belongs_to :user

  #before_save :add_days, on: :create

  #scope :unreviewed, -> { where('review_date <= ?', Date.today) }

  def self.get_random
    order('RANDOM()').first
   # unreviewed.order('RANDOM()').first
    # order('RANDOM()').first
  end

  protected

  def add_days
    self.review_date = Date.today + 3.days
  end

  def same_words
    if original_text.casecmp(translated_text.downcase).zero?
      errors.add(:translated_text, 'Translated text cannot equal original text')
    end
  end
end
