class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name, limit: 100
      t.string :email, limit: 100
      t.string :phone, limit: 20
      t.string :password_digest, limit:100
      t.string :gender, limit: 1
      t.date :birthday

      t.timestamps
    end
  end
end
