class BookingDetail < ApplicationRecord
  belongs_to :booking

  validates :patient_name, presence: true, length: { minimum: 5}
  validates :email, presence: true, length: { minimum: 5}
  validates :phone, presence: true, length: { minimum: 9, maximum:20}
  validates :birthday, presence: true
  validates :payment_type, presence: true, length: { minimum: 3}
end
