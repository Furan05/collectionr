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

ActiveRecord::Schema[7.1].define(version: 2024_12_18_113220) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "offer_id", null: false
    t.datetime "purchase_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.string "checkout_session_id"
    t.integer "amount_cents", default: 0, null: false
    t.index ["offer_id"], name: "index_achats_on_offer_id"
    t.index ["user_id"], name: "index_achats_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tcg"
    t.string "tcg_id"
    t.string "image"
    t.string "set"
    t.string "set_logo"
    t.integer "estimated_price_cents", default: 0, null: false
    t.datetime "price_updated_at"
    t.index ["price_updated_at"], name: "index_cards_on_price_updated_at"
  end

  create_table "collection_types", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.bigint "card_id", null: false
    t.string "tcg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_collection_types_on_card_id"
    t.index ["collection_id"], name: "index_collection_types_on_collection_id"
  end

  create_table "collections", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.date "release_date"
    t.string "tcg"
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "card_id", null: false
    t.integer "limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_favorites_on_card_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string "title"
    t.string "condition"
    t.text "bio"
    t.string "langue"
    t.boolean "graduation"
    t.string "image_url"
    t.bigint "card_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.boolean "etat", default: true
    t.index ["card_id"], name: "index_offers_on_card_id"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "pays"
    t.string "city"
    t.string "address"
    t.string "postal_code"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "achats", "offers"
  add_foreign_key "achats", "users"
  add_foreign_key "collection_types", "cards"
  add_foreign_key "collection_types", "collections"
  add_foreign_key "collections", "users"
  add_foreign_key "favorites", "cards"
  add_foreign_key "favorites", "users"
  add_foreign_key "offers", "cards"
  add_foreign_key "offers", "users"
end
