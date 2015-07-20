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

ActiveRecord::Schema.define(version: 20150719123218) do

  create_table "card_categories", force: true do |t|
    t.string   "name"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_visible", default: true
  end

  add_index "card_categories", ["subject_id"], name: "index_card_categories_on_subject_id"

  create_table "cards", force: true do |t|
    t.string   "question"
    t.string   "answer"
    t.integer  "card_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
    t.boolean  "is_visible",       default: true
  end

  add_index "cards", ["card_category_id"], name: "index_cards_on_card_category_id"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_id"
    t.boolean  "is_visible", default: true
  end

  add_index "categories", ["subject_id"], name: "index_categories_on_subject_id"

  create_table "comments", force: true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.integer  "solution_id"
    t.boolean  "is_to_task"
    t.string   "content"
    t.integer  "stars"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["solution_id"], name: "index_comments_on_solution_id"
  add_index "comments", ["task_id"], name: "index_comments_on_task_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "lists", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_visible",  default: true
  end

  add_index "lists", ["category_id"], name: "index_lists_on_category_id"

  create_table "logs", force: true do |t|
    t.integer  "user_id"
    t.integer  "model_id"
    t.string   "model_class"
    t.string   "action_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logs", ["user_id"], name: "index_logs_on_user_id"

  create_table "no_progresses", force: true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_id"
  end

  add_index "no_progresses", ["subject_id"], name: "index_no_progresses_on_subject_id"
  add_index "no_progresses", ["task_id"], name: "index_no_progresses_on_task_id"
  add_index "no_progresses", ["user_id"], name: "index_no_progresses_on_user_id"

  create_table "points", force: true do |t|
    t.float    "percent"
    t.integer  "user_id"
    t.integer  "card_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "level",      default: 0.15
  end

  add_index "points", ["card_id"], name: "index_points_on_card_id"
  add_index "points", ["user_id"], name: "index_points_on_user_id"

  create_table "progresses", force: true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_id"
    t.boolean  "is_verified"
  end

  add_index "progresses", ["subject_id"], name: "index_progresses_on_subject_id"
  add_index "progresses", ["task_id"], name: "index_progresses_on_task_id"
  add_index "progresses", ["user_id"], name: "index_progresses_on_user_id"

  create_table "solutions", force: true do |t|
    t.string   "url"
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_visible", default: true
  end

  add_index "solutions", ["task_id"], name: "index_solutions_on_task_id"
  add_index "solutions", ["user_id"], name: "index_solutions_on_user_id"

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "first_exam"
    t.datetime "second_exam"
    t.boolean  "is_visible",  default: true
  end

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.boolean  "status"
    t.integer  "level"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_visible", default: true
  end

  add_index "tasks", ["list_id"], name: "index_tasks_on_list_id"

  create_table "tickets", force: true do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.boolean  "accepted"
    t.boolean  "is_access"
    t.boolean  "is_manage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["subject_id"], name: "index_tickets_on_subject_id"
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
