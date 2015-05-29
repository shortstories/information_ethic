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

ActiveRecord::Schema.define(version: 20150529052207) do

  create_table "assigned_exercises", force: :cascade do |t|
    t.integer "user_id",     limit: 4,                 null: false
    t.integer "exercise_id", limit: 4,                 null: false
    t.boolean "passed",      limit: 1, default: false
  end

  add_index "assigned_exercises", ["exercise_id"], name: "fgk_ass_exercise", using: :btree
  add_index "assigned_exercises", ["user_id"], name: "fgk_ass_user", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 50, null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "category",   limit: 255
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "results", force: :cascade do |t|
    t.integer "user_id", limit: 4, null: false
    t.integer "times",   limit: 4, null: false
    t.integer "score_1", limit: 4, null: false
    t.integer "score_2", limit: 4, null: false
    t.integer "score_3", limit: 4, null: false
    t.integer "score_4", limit: 4, null: false
    t.integer "score_5", limit: 4, null: false
  end

  add_index "results", ["user_id"], name: "fgk_user_result_idx", using: :btree

  create_table "tests", force: :cascade do |t|
    t.integer "category_id", limit: 4,        null: false
    t.text    "content",     limit: 16777215
    t.integer "score",       limit: 4
  end

  add_index "tests", ["category_id"], name: "fgk_test_category_idx", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "assigned_exercises", "exercises", name: "fgk_ass_exercise"
  add_foreign_key "assigned_exercises", "users", name: "fgk_ass_user"
  add_foreign_key "results", "users", name: "fgk_user_result"
  add_foreign_key "tests", "categories", name: "fgk_test_category"
end
