class CreateReservationsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.text :code, null: false
      t.integer :guest_id, null: false

      t.string :start_date, null: false
      t.string :end_date, null: false

      t.integer :nights, null: false, default: 0

      t.integer :adult_guest_count, null: false, default: 0
      t.integer :children_guest_count, null: false, default: 0
      t.integer :infant_guest_count, null: false, default: 0

      t.decimal :security_price, null: false, precision: 8, scale: 2, default: 0
      t.decimal :payout_price, null: false, precision: 8, scale: 2, default: 0
      t.decimal :total_price, null: false, precision: 8, scale: 2, default: 0

      t.string  :currency, null: false
      t.string :status, null: false

      t.timestamps
    end

    add_index :reservations, [:code], unique: true
    add_index :reservations, [:guest_id]
  end
end
