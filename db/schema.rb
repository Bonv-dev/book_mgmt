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

ActiveRecord::Schema[8.1].define(version: 2026_01_12_064148) do
  create_table "books", force: :cascade do |t|
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.boolean "enabled", default: true
    t.string "isbn"
    t.string "memo"
    t.string "name"
    t.integer "step_id", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["step_id"], name: "index_books_on_step_id"
  end

  create_table "cabinets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "enabled", default: true
    t.integer "floor_id", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["floor_id"], name: "index_cabinets_on_floor_id"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "enabled", default: true
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "floors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "enabled", default: true
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "logs", force: :cascade do |t|
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.integer "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["book_id"], name: "index_logs_on_book_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "steps", force: :cascade do |t|
    t.integer "cabinet_id", null: false
    t.datetime "created_at", null: false
    t.boolean "enabled", default: true
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["cabinet_id"], name: "index_steps_on_cabinet_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.boolean "enabled", default: true
    t.string "encrypted_password", default: "", null: false
    t.boolean "is_admin", default: false
    t.boolean "is_librarian", default: false
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "books", "categories"
  add_foreign_key "books", "steps"
  add_foreign_key "cabinets", "floors"
  add_foreign_key "logs", "books"
  add_foreign_key "logs", "users"
  add_foreign_key "steps", "cabinets"
end
