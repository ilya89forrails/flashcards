class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true 
  
  before_save :add_days, on: :create
  before_save :same_words, on: :create


  protected

  def add_days
  	self.review_date = self.review_date + 3.days
  end

  def same_words
    if (self.original_text.downcase == self.translated_text.downcase)
    	errors.add(:translated_text, "Translated text cannot equal original text")
    end
  end

end
