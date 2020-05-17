class Customer < ApplicationRecord
  has_many :booking
  validates_confirmation_of :password
  has_secure_password

  validates :name, presence: true, length: {minimum: 5, maximum: 100}

  validates :email, presence: true, :uniqueness => {:case_sensitive => false}
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  
end
