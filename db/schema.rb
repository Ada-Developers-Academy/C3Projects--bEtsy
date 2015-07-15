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

ActiveRecord::Schema.define(version: 20150715013039) do

  create_table "orders", force: :cascade do |t|
    t.string   "status",        default: "pending"
    t.string   "email"
    t.string   "cc_name"
    t.integer  "cc_number"
    t.date     "cc_expiration"
    t.integer  "cc_cvv"
    t.integer  "billing_zip"
    t.boolean  "shipped"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "mailing_zip"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

end
