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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20151103135929) do

  create_table "expenditures", :force => true do |t|
    t.text     "description"
    t.float    "value"
    t.boolean  "to_all"
    t.integer  "house_id"
    t.datetime "until"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "state",       :default => "unfinished"
  end

  create_table "expenditureusers", :force => true do |t|
    t.integer  "expenditure_id"
    t.integer  "user_id"
    t.string   "state",          :default => "unfinished"
    t.string   "request",        :default => "waiting"
    t.float    "debt"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "expenditureusers", ["expenditure_id", "user_id"], :name => "index_expenditureusers_on_expenditure_id_and_user_id", :unique => true
  add_index "expenditureusers", ["expenditure_id"], :name => "index_expenditureusers_on_expenditure_id"
  add_index "expenditureusers", ["user_id"], :name => "index_expenditureusers_on_user_id"

  create_table "house_admins", :force => true do |t|
    t.integer  "house_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "house_admins", ["house_id", "user_id"], :name => "index_house_admins_on_house_id_and_user_id", :unique => true
  add_index "house_admins", ["house_id"], :name => "index_house_admins_on_house_id"
  add_index "house_admins", ["user_id"], :name => "index_house_admins_on_user_id"

  create_table "houses", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "token"
    t.integer  "roles_mask"
    t.string   "state"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.float    "debt",                   :default => 0.0
    t.integer  "house_id"
  end

  add_index "users", ["token"], :name => "index_users_on_token"

end
