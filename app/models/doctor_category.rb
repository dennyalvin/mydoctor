class DoctorCategory < ApplicationRecord
  belongs_to :doctor
  belongs_to :category
end
