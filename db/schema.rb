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

ActiveRecord::Schema.define(version: 20170306234249) do

  create_table "channel_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channels", force: true do |t|
    t.string   "name"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customer_mcs", force: true do |t|
    t.integer  "channel_id"
    t.integer  "customer_id"
    t.string   "name"
    t.string   "mc_id"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ebay_insertion_timelines", force: true do |t|
    t.integer  "ebay_insertion_id"
    t.integer  "tm_num_impressions"
    t.integer  "tm_num_visits"
    t.integer  "tm_num_solded"
    t.integer  "tm_num_questions"
    t.integer  "tm_num_follows"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ebay_insertions", force: true do |t|
    t.string   "ebay_id",         limit: 20
    t.string   "title",           limit: 100
    t.string   "category_name",   limit: 200
    t.string   "category_name_1", limit: 50
    t.string   "category_name_2", limit: 50
    t.string   "category_name_3", limit: 50
    t.string   "category_name_4", limit: 50
    t.string   "category_name_5", limit: 50
    t.string   "created_from",    limit: 10
    t.decimal  "price",                       precision: 10, scale: 2
    t.decimal  "shipping_cost",               precision: 10, scale: 2
    t.date     "start_date"
    t.integer  "num_impressions"
    t.integer  "num_visits"
    t.integer  "num_solded"
    t.integer  "num_questions"
    t.integer  "num_follows"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_rows", force: true do |t|
    t.integer  "order_id"
    t.string   "mc_transaction"
    t.string   "mc_item"
    t.string   "mc_title"
    t.integer  "qty"
    t.decimal  "price",                   precision: 7, scale: 2
    t.integer  "product_id"
    t.integer  "product_mc_id"
    t.integer  "product_variation_id"
    t.integer  "product_variation_mc_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "channel_id"
    t.integer  "customer_id"
    t.integer  "customer_mc_id"
    t.string   "order_identifier"
    t.decimal  "total_value",             precision: 7, scale: 2
    t.decimal  "products_value",          precision: 7, scale: 2
    t.decimal  "shipping_value",          precision: 7, scale: 2
    t.decimal  "amount_paid",             precision: 7, scale: 2
    t.date     "created_on"
    t.datetime "created_on_ts"
    t.date     "paid_on"
    t.datetime "paid_on_ts"
    t.date     "shipping_on"
    t.datetime "shipping_on_ts"
    t.date     "estimate_delivery_on"
    t.datetime "estimate_delivery_on_ts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_mcs", force: true do |t|
    t.integer  "channel_id"
    t.integer  "product_id"
    t.string   "mc_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category_name",   limit: 200
    t.string   "category_name_1", limit: 50
    t.string   "category_name_2", limit: 50
    t.string   "category_name_3", limit: 50
    t.string   "category_name_4", limit: 50
    t.string   "category_name_5", limit: 50
    t.string   "category_name_6", limit: 50
    t.string   "category_name_7", limit: 50
    t.string   "created_from",    limit: 10
    t.decimal  "price",                       precision: 10, scale: 2
    t.decimal  "shipping_cost",               precision: 10, scale: 2
    t.date     "start_date"
    t.integer  "num_impressions"
    t.integer  "num_visits"
    t.integer  "num_solded"
    t.integer  "num_questions"
    t.integer  "num_follows"
  end

  create_table "product_variation_mcs", force: true do |t|
    t.integer  "channel_id"
    t.integer  "product_mc_id"
    t.string   "variation_string"
    t.string   "name"
    t.integer  "product_variation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_variations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "manufacturer_id"
    t.string   "manufacturer_ref"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test01s", force: true do |t|
    t.string   "title"
    t.decimal  "price",      precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
