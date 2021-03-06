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

ActiveRecord::Schema.define(version: 2021_11_06_133147) do

  create_table "comments", force: :cascade do |t|
    t.string "text"
    t.string "user_id"
    t.string "replayedComment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "contribution_id"
    t.integer "points", default: 0
  end

  create_table "comments_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "comment_id", null: false
  end

  create_table "contributions", force: :cascade do |t|
    t.string "url"
    t.string "text"
    t.string "title"
    t.string "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "points", default: 0
    t.string "contribution_type"
  end

  create_table "contributions_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "contribution_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_name"
    t.integer "karma", default: 0
    t.string "about", default: ""
    t.boolean "show_dead", default: false
    t.boolean "no_procrast", default: false
    t.integer "max_visit", default: 20
    t.integer "min_away", default: 180
    t.integer "delay", default: 0
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
