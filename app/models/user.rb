class User < ApplicationRecord
  has_many :credit_cards
  has_many :transactions
  has_secure_password

  validates :email_address, presence: true, uniqueness: true
  validate :email_format

  private

  def email_format
    unless /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.match?(email_address)
      errors.add(:email_address, 'has an invalid format')
    end
  end
end
