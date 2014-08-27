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

ActiveRecord::Schema.define(version: 20140827210444) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "preflight_campaign_subscriptions", force: true do |t|
    t.integer  "subscriber_id",                null: false
    t.integer  "campaign_id",                  null: false
    t.integer  "referrer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token", limit: 255, null: false
  end

  add_index "preflight_campaign_subscriptions", ["invitation_token", "campaign_id"], name: "invitation_token_uniq", unique: true, using: :btree
  add_index "preflight_campaign_subscriptions", ["referrer_id"], name: "index_preflight_campaign_subscriptions_on_referrer_id", using: :btree
  add_index "preflight_campaign_subscriptions", ["subscriber_id", "campaign_id"], name: "campaign_subscriptions_uniq", unique: true, using: :btree

  create_table "preflight_campaigns", force: true do |t|
    t.string   "title",       limit: 255, null: false
    t.string   "cached_slug", limit: 255, null: false
    t.datetime "started_at",              null: false
    t.datetime "ended_at"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preflight_campaigns", ["cached_slug"], name: "index_preflight_campaigns_on_cached_slug", unique: true, using: :btree
  add_index "preflight_campaigns", ["started_at", "ended_at"], name: "index_preflight_campaigns_on_started_at_and_ended_at", using: :btree
  add_index "preflight_campaigns", ["title"], name: "index_preflight_campaigns_on_title", unique: true, using: :btree

  create_table "preflight_reward_grants", force: true do |t|
    t.integer  "campaign_subscription_id", null: false
    t.integer  "reward_id",                null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "preflight_reward_grants", ["campaign_subscription_id", "reward_id"], name: "uniq_grant", unique: true, using: :btree
  add_index "preflight_reward_grants", ["campaign_subscription_id"], name: "index_preflight_reward_grants_on_campaign_subscription_id", using: :btree

  create_table "preflight_rewards", force: true do |t|
    t.integer  "campaign_id",     null: false
    t.string   "title",           null: false
    t.text     "description",     null: false
    t.integer  "rank",            null: false
    t.integer  "threshold_units", null: false
    t.string   "threshold_type",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preflight_rewards", ["campaign_id", "rank"], name: "index_preflight_rewards_on_campaign_id_and_rank", unique: true, using: :btree
  add_index "preflight_rewards", ["campaign_id"], name: "index_preflight_rewards_on_campaign_id", using: :btree

  create_table "preflight_shares", force: true do |t|
    t.string   "provider",                 limit: 255, null: false
    t.string   "uid",                      limit: 255
    t.integer  "campaign_subscription_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preflight_shares", ["campaign_subscription_id"], name: "index_preflight_shares_on_campaign_subscription_id", using: :btree
  add_index "preflight_shares", ["provider", "uid"], name: "index_preflight_shares_on_provider_and_uid", using: :btree

  create_table "preflight_subscribers", force: true do |t|
    t.string   "email",      limit: 255, null: false
    t.string   "ip_address", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preflight_subscribers", ["email"], name: "index_preflight_subscribers_on_email", unique: true, using: :btree

end
