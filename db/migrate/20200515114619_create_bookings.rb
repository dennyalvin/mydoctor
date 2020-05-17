class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :hospital, null: false, foreign_key: true
      t.date :schedule_date
      t.time :start_time
      t.time :end_time
      t.string :status, limit: 50

      t.timestamps
    end
  end
end
