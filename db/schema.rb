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

ActiveRecord::Schema.define(version: 20131230220724) do

  create_table "matches", force: true do |t|
    t.string   "match_type"
    t.date     "date"
    t.string   "rival_name"
    t.string   "my_team"
    t.string   "rival_team"
    t.integer  "my_score"
    t.integer  "rival_score"
    t.integer  "my_shots"
    t.integer  "rival_shots"
    t.integer  "my_shots_on_goal"
    t.integer  "rival_shots_on_goal"
    t.integer  "my_possession"
    t.integer  "rival_possession"
    t.integer  "my_pass_accuracy"
    t.integer  "rival_pass_accuracy"
    t.integer  "my_tackles_made"
    t.integer  "rival_tackles_made"
    t.integer  "my_fouls"
    t.integer  "rival_fouls"
    t.integer  "my_yellow_cards"
    t.integer  "rival_yellow_cards"
    t.integer  "my_red_cards"
    t.integer  "rival_red_cards"
    t.integer  "my_offsides"
    t.integer  "rival_offsides"
    t.integer  "my_pass_attempts"
    t.integer  "rival_pass_attempts"
    t.integer  "my_passes_made"
    t.integer  "rival_passes_made"
    t.string   "digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["digest"], name: "index_matches_on_digest", using: :btree

end
