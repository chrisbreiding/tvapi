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

ActiveRecord::Schema.define(version: 20150315003505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "episodes", force: :cascade do |t|
    t.integer  "season"
    t.integer  "episode_number"
    t.string   "title"
    t.datetime "airdate"
    t.integer  "show_id"
  end

  add_index "episodes", ["show_id"], name: "index_episodes_on_show_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.datetime "last_updated"
  end

  create_table "shows", force: :cascade do |t|
    t.string "display_name"
    t.string "search_name"
    t.string "file_name"
    t.string "source_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "api_key"
    t.string "view_link"
  end

  create_table "viewerships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "show_id"
  end

  add_index "viewerships", ["show_id"], name: "index_viewerships_on_show_id", using: :btree
  add_index "viewerships", ["user_id"], name: "index_viewerships_on_user_id", using: :btree

end
