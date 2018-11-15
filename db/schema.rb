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

ActiveRecord::Schema.define(version: 20180706043217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comentratings", force: :cascade do |t|
    t.integer "star"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "coment_id"
    t.index ["coment_id"], name: "index_comentratings_on_coment_id"
    t.index ["user_id"], name: "index_comentratings_on_user_id"
  end

  create_table "coments", force: :cascade do |t|
    t.date "date"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "post_id"
    t.index ["post_id"], name: "index_coments_on_post_id"
    t.index ["user_id"], name: "index_coments_on_user_id"
  end

  create_table "dashboards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_favorites_on_post_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "foros", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "moderator_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "tema_id"
    t.index ["tema_id"], name: "index_moderator_requests_on_tema_id"
    t.index ["user_id"], name: "index_moderator_requests_on_user_id"
  end

  create_table "moderators", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "tema_id"
    t.index ["tema_id"], name: "index_moderators_on_tema_id"
    t.index ["user_id"], name: "index_moderators_on_user_id"
  end

  create_table "postratings", force: :cascade do |t|
    t.integer "star"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "post_id"
    t.index ["post_id"], name: "index_postratings_on_post_id"
    t.index ["user_id"], name: "index_postratings_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.date "date"
    t.string "section"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "tema_id"
    t.index ["tema_id"], name: "index_posts_on_tema_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "relationships", id: :serial, force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "tema_id"
    t.index ["tema_id"], name: "index_subscriptions_on_tema_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "temas", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "foro_id"
    t.index ["foro_id"], name: "index_temas_on_foro_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "avatar"
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comentratings", "coments"
  add_foreign_key "comentratings", "users"
  add_foreign_key "coments", "posts"
  add_foreign_key "coments", "users"
  add_foreign_key "favorites", "posts"
  add_foreign_key "favorites", "users"
  add_foreign_key "moderator_requests", "temas"
  add_foreign_key "moderator_requests", "users"
  add_foreign_key "moderators", "temas"
  add_foreign_key "moderators", "users"
  add_foreign_key "postratings", "posts"
  add_foreign_key "postratings", "users"
  add_foreign_key "posts", "temas"
  add_foreign_key "posts", "users"
  add_foreign_key "subscriptions", "temas"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "temas", "foros"
end
