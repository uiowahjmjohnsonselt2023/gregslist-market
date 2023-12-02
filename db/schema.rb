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

ActiveRecord::Schema[7.1].define(version: 2023_11_25_033926) do
  create_table "buyers", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.text "payment_method"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buyers_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "buyer_id", null: false
    t.index ["user_id", "buyer_id"], name: "index_buyers_users_on_user_id_and_buyer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_categories", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_item_categories_on_category_id"
    t.index ["item_id"], name: "index_item_categories_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "seller_id", null: false
    t.date "listing_date"
    t.decimal "listed_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seller_id"], name: "index_items_on_seller_id"
  end


  create_table "seller_reviews", force: :cascade do |t|
    t.integer "seller_id", null: false
    t.integer "user_id", null: false
    t.integer "rating"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seller_id"], name: "index_seller_reviews_on_seller_id"
    t.index ["user_id"], name: "index_seller_reviews_on_user_id"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sellers_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "seller_id", null: false
    t.index ["user_id", "seller_id"], name: "index_sellers_users_on_user_id_and_seller_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
  end

  add_foreign_key "item_categories", "categories"
  add_foreign_key "item_categories", "items"
  add_foreign_key "items", "sellers"
  add_foreign_key "seller_reviews", "sellers"
  add_foreign_key "seller_reviews", "users"
end
