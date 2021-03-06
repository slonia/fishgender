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

ActiveRecord::Schema.define(version: 20171217082308) do

  create_table "photos", force: :cascade do |t|
    t.string "image"
    t.integer "used", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "tags"
    t.boolean "active", default: true, null: false
    t.integer "source", default: 0, null: false
    t.string "instagram_id"
    t.string "fingerprint"
    t.string "instagram_code"
  end

  create_table "words", force: :cascade do |t|
    t.string "word"
    t.integer "used", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind", default: 0, null: false
  end

end
