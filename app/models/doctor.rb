class Doctor < ApplicationRecord
    has_many :doctor_category
    has_many :booking
end
