class CreateDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors do |t|
      t.string :name, limit: 100

      t.timestamps
    end
  end
end
