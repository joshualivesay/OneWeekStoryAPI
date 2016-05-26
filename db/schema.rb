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

ActiveRecord::Schema.define(version: 20160514133913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "points"
    t.text     "type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "story_id"
    t.string   "email"
    t.string   "text"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_invitations_on_story_id", using: :btree
  end

  create_table "oneups", force: :cascade do |t|
    t.integer  "story_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_oneups_on_story_id", using: :btree
    t.index ["user_id"], name: "index_oneups_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_posts_on_story_id", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "stories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "status"
    t.datetime "start_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "on_turn"
  end

  create_table "story_awards", force: :cascade do |t|
    t.integer  "story_id"
    t.integer  "award_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["award_id"], name: "index_story_awards_on_award_id", using: :btree
    t.index ["story_id"], name: "index_story_awards_on_story_id", using: :btree
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "phone_number", null: false
    t.string   "description",  null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "user_awards", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "award_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["award_id"], name: "index_user_awards_on_award_id", using: :btree
    t.index ["user_id"], name: "index_user_awards_on_user_id", using: :btree
  end

  create_table "user_stories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.boolean  "owner"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_user_stories_on_story_id", using: :btree
    t.index ["user_id"], name: "index_user_stories_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password"
    t.integer  "points",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "invitations", "stories"
  add_foreign_key "oneups", "stories"
  add_foreign_key "oneups", "users"
  add_foreign_key "posts", "stories"
  add_foreign_key "posts", "users"
  add_foreign_key "story_awards", "awards"
  add_foreign_key "story_awards", "stories"
  add_foreign_key "user_awards", "awards"
  add_foreign_key "user_awards", "users"
  add_foreign_key "user_stories", "stories"
  add_foreign_key "user_stories", "users"
end
