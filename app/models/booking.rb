class Booking < ApplicationRecord
  belongs_to :doctor
  belongs_to :hospital
  belongs_to :customer
  has_one :booking_detail
end
