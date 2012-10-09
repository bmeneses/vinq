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

ActiveRecord::Schema.define(:version => 20121003022215) do

  create_table "appellations", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "region_id",  :limit => 8
  end

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "geolocations", :force => true do |t|
    t.float    "lat"
    t.float    "long"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "product_attributes", :force => true do |t|
    t.integer  "wine_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "product_attributes_wines", :id => false, :force => true do |t|
    t.integer "product_attribute_id"
    t.integer "wine_id"
  end

  add_index "product_attributes_wines", ["product_attribute_id", "wine_id"], :name => "idx_wines_product_attributes"

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "area_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "varietals", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "winetype_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "wines", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "wine_type"
    t.string   "year"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "appellation_id"
    t.integer  "varietal_id"
    t.decimal  "price_min"
    t.decimal  "price_max"
    t.decimal  "price_retail"
    t.integer  "product_attribute_id"
  end

end
