class DoctorScheduleSerializer < ActiveModel::Serializer
  attributes :id, :date, :opening_hour, :closing_hour, :booking
end
