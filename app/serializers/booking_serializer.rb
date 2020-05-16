class BookingSerializer < ActiveModel::Serializer
  attributes :id, :customer_id, :schedule_date , :start_time, :end_time , :status, :created_at
  belongs_to :doctor, serializer: DoctorSerializer
  has_one :booking_detail, serializer: BookingDetailSerializer
end
