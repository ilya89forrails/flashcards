class User < ApplicationRecord
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :cards
  validates_confirmation_of :password, message: 'should match confirmation', if: :password

  def has_linked_github?
    authentications.where(provider: 'github').present?
  end
end
