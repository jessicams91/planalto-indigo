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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160407212508) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_prices", force: :cascade do |t|
    t.string   "shop_name"
    t.string   "card_link"
    t.integer  "quantity"
    t.decimal  "price"
    t.integer  "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "card_prices", ["card_id"], name: "index_card_prices_on_card_id", using: :btree

  create_table "cards", force: :cascade do |t|
    t.string   "name_en"
    t.string   "name_pt"
    t.string   "card_type"
    t.string   "element"
    t.string   "rarity"
    t.string   "number"
    t.string   "photo"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "expansion_id"
  end

  add_index "cards", ["expansion_id"], name: "index_cards_on_expansion_id", using: :btree

  create_table "expansions", force: :cascade do |t|
    t.string   "name_en"
    t.string   "name_pt"
    t.integer  "card_total"
    t.string   "prefix"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "icon"
    t.string   "expansion_link"
    t.string   "series"
  end

  add_foreign_key "card_prices", "cards"
  add_foreign_key "cards", "expansions"
end
