class DoctorScheduleSerializer < ActiveModel::Serializer
  attributes :id, :date, :start_time, :end_time, :booking

  def start_time
  	object.start_time.to_formatted_s(:time)
  end

  def end_time
  	object.end_time.to_formatted_s(:time)
  end
end
