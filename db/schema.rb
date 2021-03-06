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

ActiveRecord::Schema.define(:version => 20120125201213) do

  create_table "alternatives", :force => true do |t|
    t.string   "name"
    t.integer  "decision_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alternatives", ["decision_id"], :name => "index_alternatives_on_decision_id"

  create_table "decisions", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public"
  end

  add_index "decisions", ["user_id"], :name => "index_decisions_on_user_id"

  create_table "factors", :force => true do |t|
    t.string   "name"
    t.integer  "decision_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight_id"
  end

  add_index "factors", ["decision_id"], :name => "index_factors_on_decision_id"

  create_table "rankings", :force => true do |t|
    t.integer  "alternative_id"
    t.integer  "factor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight_id"
  end

  add_index "rankings", ["alternative_id"], :name => "index_rankings_on_alternative_id"
  add_index "rankings", ["factor_id"], :name => "index_rankings_on_factor_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "realname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
