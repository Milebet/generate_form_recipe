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

ActiveRecord::Schema.define(version: 2019_04_01_225128) do

  create_table "doctors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "document_type"
    t.string "document"
    t.string "first_name"
    t.string "second_name"
    t.string "last_name"
    t.string "second_last_name"
    t.string "married_name"
    t.date "birth_date"
    t.string "genre"
    t.string "local_phone"
    t.string "cell_phone"
    t.string "country"
    t.string "city"
    t.text "address"
    t.string "speciality"
    t.string "years_experience"
    t.string "photo"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.bigint "photo_file_size"
    t.datetime "photo_updated_at"
    t.string "token", null: false
    t.index ["email"], name: "index_doctors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_doctors_on_reset_password_token", unique: true
  end

  create_table "medicines", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "quantity"
    t.string "indications"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medicines_recipes", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "medicine_id", null: false
    t.index ["medicine_id", "recipe_id"], name: "index_medicines_recipes_on_medicine_id_and_recipe_id"
    t.index ["recipe_id", "medicine_id"], name: "index_medicines_recipes_on_recipe_id_and_medicine_id"
  end

  create_table "recipe_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "recipe_id"
    t.string "medicine_name"
    t.string "quantity"
    t.string "indications"
    t.index ["recipe_id"], name: "index_recipe_details_on_recipe_id"
  end

  create_table "recipes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "doctors_id"
    t.string "full_name"
    t.string "email"
    t.string "cell_phone"
    t.string "local_phone"
    t.string "document_type"
    t.string "document"
    t.bigint "doctor_id"
    t.index ["doctor_id"], name: "index_recipes_on_doctor_id"
    t.index ["doctors_id"], name: "index_recipes_on_doctors_id"
  end

  add_foreign_key "recipe_details", "recipes"
  add_foreign_key "recipes", "doctors"
  add_foreign_key "recipes", "doctors", column: "doctors_id"
end
