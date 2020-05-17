class BookingSerializer < ActiveModel::Serializer
  attributes :id, :customer_id, :schedule_date , :start_time, :end_time , :status, :created_at
  belongs_to :doctor, serializer: DoctorSerializer
  has_one :booking_detail, serializer: BookingDetailSerializer

  def start_time
  	object.start_time.to_formatted_s(:time)
  end

  def end_time
  	object.end_time.to_formatted_s(:time)
  end
end
