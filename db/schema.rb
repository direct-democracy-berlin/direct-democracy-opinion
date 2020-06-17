# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_21_141632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "token", null: false
    t.bigint "user_id", null: false
    t.string "action", null: false
    t.jsonb "payload"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_actions_on_token", unique: true
    t.index ["user_id"], name: "index_actions_on_user_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.string "user_agent", null: false
    t.string "user_agent_key", null: false
    t.string "session_name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_agent_key"], name: "index_devices_on_user_agent_key"
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "thesis_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["thesis_id"], name: "index_taggings_on_thesis_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "theses", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "votes_up", default: 0, null: false
    t.integer "votes_down", default: 0, null: false
    t.integer "votes_neutral", default: 0, null: false
    t.bigint "creator_id", null: false
    t.string "system_template"
    t.index ["creator_id"], name: "index_theses_on_creator_id"
    t.index ["system_template"], name: "index_theses_on_system_template"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false, null: false
    t.boolean "tutorial_welcome", default: false
    t.boolean "tutorial_first_thesis", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "thesis_id", null: false
    t.string "vote", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["thesis_id"], name: "index_votes_on_thesis_id"
    t.index ["user_id", "thesis_id"], name: "index_votes_on_user_id_and_thesis_id", unique: true
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "actions", "users"
  add_foreign_key "devices", "users"
  add_foreign_key "taggings", "tags"
  add_foreign_key "taggings", "theses"
  add_foreign_key "theses", "users", column: "creator_id"
  add_foreign_key "votes", "theses", on_delete: :cascade
  add_foreign_key "votes", "users", on_delete: :cascade
end
