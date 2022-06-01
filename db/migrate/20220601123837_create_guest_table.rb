class CreateGuestTable < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.text :email, null: false
      t.text :first_name, null: false
      t.text :last_name, null: false

      t.timestamps

      t.index [:email], unique: true
    end
  end
end
