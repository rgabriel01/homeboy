# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_01_131450) do
  create_table "guests", force: :cascade do |t|
    t.text "email", null: false
    t.text "first_name", null: false
    t.text "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_guests_on_email", unique: true
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.integer "guest_id", null: false
    t.text "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "guest_phone_number_index"
  end

  create_table "reservations", force: :cascade do |t|
    t.text "code", null: false
    t.integer "guest_id", null: false
    t.string "start_date", null: false
    t.string "end_date", null: false
    t.integer "nights", default: 0, null: false
    t.integer "adult_guest_count", default: 0, null: false
    t.integer "children_guest_count", default: 0, null: false
    t.integer "infant_guest_count", default: 0, null: false
    t.decimal "security_price", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "payout_price", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "total_price", precision: 8, scale: 2, default: "0.0", null: false
    t.string "currency", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_reservations_on_code", unique: true
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
  end

end
