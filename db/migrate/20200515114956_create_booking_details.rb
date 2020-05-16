class CreateBookingDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :booking_details do |t|
      t.references :booking, null: false, foreign_key: true
      t.string :patient_name, limit: 100
      t.string :email, limit: 100
      t.string :phone, limit: 20
      t.date :birthday
      t.string :payment_type, limit: 50
      t.text :notes

      t.timestamps
    end
  end
end
