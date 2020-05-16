class CreateHospitals < ActiveRecord::Migration[6.0]
  def change
    create_table :hospitals do |t|
      t.string :name, limit: 100
      t.text :address

      t.timestamps
    end
  end
end
