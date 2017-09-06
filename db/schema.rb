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

ActiveRecord::Schema.define(version: 20170905212826) do

  create_table "customers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "image"
    t.integer  "gender"
    t.string   "city"
    t.string   "street"
    t.datetime "postcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "color"
    t.integer  "employee_id"
    t.integer  "customer_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "eventable_id"
    t.string   "eventable_type"
    t.integer  "created_by"
    t.text     "description"
    t.integer  "status",             default: 0
    t.string   "type"
    t.string   "contact"
    t.string   "city"
    t.string   "street"
    t.string   "zip"
    t.string   "address_line"
    t.text     "recurring"
    t.datetime "end"
    t.datetime "start"
    t.integer  "priority",           default: 0
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "run_at"
    t.integer  "parent_id"
    t.integer  "cost_type",          default: 0
    t.decimal  "total_cost",         default: "0.0"
    t.decimal  "event_cost",         default: "0.0"
    t.integer  "recurring_type"
    t.datetime "recurring_end_at"
    t.integer  "recurring_end_time", default: 0
    t.string   "job_id"
    t.index ["customer_id"], name: "index_events_on_customer_id"
    t.index ["employee_id"], name: "index_events_on_employee_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.integer  "employee_id"
    t.text     "recurring"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.string   "type"
    t.datetime "deleted_at"
    t.integer  "status",                 default: 0
    t.string   "image"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "gender"
    t.string   "dob"
    t.string   "phone"
    t.string   "street"
    t.string   "city"
    t.string   "postcode"
    t.float    "hourly_rate"
    t.string   "picture"
    t.string   "color"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
