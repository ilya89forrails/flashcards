class Card < ApplicationRecord
  validates :original_text, :translated_text, :review_date, presence: true
  # validate :same_words, on: :create
  mount_uploader :pic, PicUploader
  belongs_to :user, optional: true
  belongs_to :deck

  before_save :add_days, on: :create

  scope :unreviewed, -> { where('review_date <= ?', Date.today) }
  scope :unreviewed_from_deck, -> (current_user) { where('review_date <= ? AND deck_id = ?', Date.today, current_user.current_deck_id) }

  def self.get_random
    # order('RANDOM()').first
    unreviewed.order('RANDOM()').first
  end

  def self.get_random_from_current_deck(current_user)
    # order('RANDOM()').first
    unreviewed_from_deck(current_user).order('RANDOM()').first
  end

  protected

  def add_days
    self.review_date = Date.today #+ 3.days
  end

  def same_words
    if original_text.casecmp(translated_text.downcase).zero?
      errors.add(:translated_text, 'Translated text cannot equal original text')
    end
  end
end
