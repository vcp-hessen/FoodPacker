# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120707093959) do

  create_table "box_stubs", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_meals", :force => true do |t|
    t.integer  "group_id"
    t.integer  "meal_id"
    t.integer  "participants_count_deviation"
    t.float    "hunger_factor"
    t.integer  "receipt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "participants_count"
    t.float    "hunger_factor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", :force => true do |t|
    t.float    "quantity"
    t.integer  "receipt_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meals", :force => true do |t|
    t.string   "name"
    t.datetime "time"
    t.integer  "receipt_id"
    t.integer  "alt_receipt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meals_receipts", :id => false, :force => true do |t|
    t.integer "meal_id"
    t.integer "receipt_id"
  end

  add_index "meals_receipts", ["meal_id", "receipt_id"], :name => "index_meals_receipts_on_meal_id_and_receipt_id"
  add_index "meals_receipts", ["receipt_id", "meal_id"], :name => "index_meals_receipts_on_receipt_id_and_meal_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receipts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
