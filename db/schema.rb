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

ActiveRecord::Schema.define(version: 20160630051249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer  "appid"
    t.string   "icon_url"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games_library_entries", force: :cascade do |t|
    t.integer "games_id"
    t.integer "library_entries_id"
    t.index ["games_id"], name: "index_games_library_entries_on_games_id", using: :btree
    t.index ["library_entries_id"], name: "index_games_library_entries_on_library_entries_id", using: :btree
  end

  create_table "library_entries", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "steam_profile_id"
    t.datetime "info_last_refreshed_at"
    t.integer  "playtime_in_hours"
    t.boolean  "recently_played"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["game_id"], name: "index_library_entries_on_game_id", using: :btree
    t.index ["steam_profile_id"], name: "index_library_entries_on_steam_profile_id", using: :btree
  end

  create_table "steam_profiles", force: :cascade do |t|
    t.datetime "info_last_refreshed_at"
    t.string   "steam_id"
    t.string   "vanity_name"
    t.index ["vanity_name"], name: "index_steam_profiles_on_vanity_name", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "vanity_name"
    t.integer  "steam_profile_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
