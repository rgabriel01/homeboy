class CreatePhoneNumbersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :phone_numbers do |t|
      t.integer :guest_id, null: false
      t.text :number
      t.timestamps
    end

    add_index :phone_numbers, [:guest_id], name: :guest_phone_number_index
  end
end
