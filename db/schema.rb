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

ActiveRecord::Schema.define(:version => 20120308111850) do

  create_table "crash_groups", :force => true do |t|
    t.integer  "project_id"
    t.string   "hash_uid"
    t.text     "message"
    t.string   "class_name"
    t.string   "location"
    t.integer  "crashes_count"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.datetime "last_error_time"
    t.boolean  "resolved",        :default => false
  end

  create_table "crashes", :force => true do |t|
    t.integer  "crash_group_id"
    t.text     "backtrace"
    t.text     "env"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "groups", :force => true do |t|
    t.integer  "project_id"
    t.string   "location"
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "uid"
    t.string   "secret"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "requests", :force => true do |t|
    t.integer  "group_id"
    t.text     "params"
    t.string   "format"
    t.string   "method"
    t.string   "path"
    t.float    "request_time"
    t.datetime "start_time"
    t.text     "env"
    t.float    "cpu"
    t.integer  "ram"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
