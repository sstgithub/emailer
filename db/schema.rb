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

ActiveRecord::Schema.define(version: 20160328115550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string   "campaign_name"
    t.string   "email_subject"
    t.text     "email_body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "sent"
  end

  create_table "campaigns_recipients", id: false, force: :cascade do |t|
    t.integer "campaign_id"
    t.integer "recipient_id"
  end

  add_index "campaigns_recipients", ["campaign_id"], name: "index_campaigns_recipients_on_campaign_id", using: :btree
  add_index "campaigns_recipients", ["recipient_id"], name: "index_campaigns_recipients_on_recipient_id", using: :btree

  create_table "mailer_services", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.string   "domain"
    t.string   "address"
    t.integer  "port"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipients", force: :cascade do |t|
    t.string   "email_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "salutation"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
