class Customer < ApplicationRecord
  # has_secure_password

  has_many :booking
  validates_confirmation_of :password
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  
  
end