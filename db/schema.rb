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

ActiveRecord::Schema.define(:version => 20120309105905) do

  create_table "domains", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "email_paths", :force => true do |t|
    t.string   "type"
    t.string   "path"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "emails", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",     :default => "",   :null => false
    t.text     "comment"
    t.date     "expires"
    t.integer  "email_path_id"
    t.string   "forward_email"
    t.boolean  "receive"
    t.string   "alt_email"
    t.boolean  "reminder_send"
    t.boolean  "active",                 :default => true
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "emails", ["email"], :name => "index_emails_on_email", :unique => true
  add_index "emails", ["expires"], :name => "index_emails_on_expires", :unique => true
  add_index "emails", ["reset_password_token"], :name => "index_emails_on_reset_password_token", :unique => true

end
