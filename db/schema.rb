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

ActiveRecord::Schema.define(version: 2020_04_08_213253) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cmps", force: :cascade do |t|
    t.string "adress"
    t.string "zipcode"
    t.string "phonenumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "street"
  end

  create_table "surveys", force: :cascade do |t|
    t.datetime "date"
    t.integer "q1"
    t.integer "q2"
    t.integer "q3"
    t.integer "q4"
    t.integer "q5"
    t.integer "q6"
    t.integer "q7"
    t.integer "q8"
    t.integer "q9"
    t.integer "q10"
    t.integer "q11"
    t.integer "q12"
    t.integer "q13"
    t.integer "q14"
    t.integer "q15"
    t.integer "q16"
    t.integer "q17"
    t.integer "q18"
    t.integer "q19"
    t.integer "q20"
    t.integer "q21"
    t.integer "q22"
    t.integer "q23"
    t.integer "q24"
    t.integer "q25"
    t.integer "q26"
    t.integer "q27"
    t.integer "depression_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "anxiety_score"
    t.integer "addiction_score"
    t.integer "abuse_score"
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "surveyid"
    t.string "notification_frequency"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["surveyid"], name: "index_users_on_surveyid", unique: true
  end

  add_foreign_key "surveys", "users"
end
