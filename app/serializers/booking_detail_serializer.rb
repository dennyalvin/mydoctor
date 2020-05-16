class BookingDetailSerializer < ActiveModel::Serializer
  attributes :patient_name, :email, :phone, :birthday, :payment_type, :notes
end
