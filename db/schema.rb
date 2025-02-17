# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_02_17_220258) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "components", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "folder_id", null: false
    t.float "price", null: false
    t.string "code"
    t.string "name", limit: 120, null: false
    t.decimal "weight", precision: 10, scale: 2, null: false
    t.string "measurement", null: false
    t.string "currency", null: false
    t.index ["folder_id"], name: "index_components_on_folder_id"
  end

  create_table "dimensions", force: :cascade do |t|
    t.integer "length", null: false
    t.integer "width", null: false
    t.integer "height", null: false
    t.bigint "component_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "measurement"
    t.index ["component_id"], name: "index_dimensions_on_component_id", unique: true
  end

  create_table "folders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "name", limit: 120, null: false
    t.string "description", limit: 120
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", limit: 120, null: false
    t.string "phone_number"
    t.string "phone_confirmation_token"
    t.datetime "token_sent_at"
    t.boolean "confirmed", default: false
    t.boolean "active", default: false
  end

  add_foreign_key "components", "folders"
  add_foreign_key "dimensions", "components", on_delete: :cascade
  add_foreign_key "folders", "users"
end
