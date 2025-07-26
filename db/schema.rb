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

ActiveRecord::Schema[8.0].define(version: 2025_07_26_205730) do
  create_table "cards", force: :cascade do |t|
    t.integer "game_id", null: false
    t.string "label"
    t.integer "value"
    t.string "suit"
    t.string "filename"
    t.boolean "drawn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_cards_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_turn"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "turns", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "turn_number"
    t.integer "wager"
    t.string "bet_type"
    t.string "result"
    t.string "card"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_turns_on_game_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.integer "balance"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "cards", "games"
  add_foreign_key "games", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "turns", "games"
end
