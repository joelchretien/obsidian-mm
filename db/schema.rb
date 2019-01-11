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

ActiveRecord::Schema.define(version: 2018_10_20_031448) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "import_configuration_options"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "budgeted_line_items", force: :cascade do |t|
    t.text "description"
    t.integer "amount_cents"
    t.integer "recurrence"
    t.integer "recurrence_multiplier"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.text "transaction_descriptions"
    t.index ["account_id"], name: "index_budgeted_line_items_on_account_id"
  end

  create_table "imported_files", force: :cascade do |t|
    t.bigint "account_id"
    t.text "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_imported_files_on_account_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "description"
    t.integer "amount_cents"
    t.date "transaction_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "budgeted_line_item_id"
    t.bigint "account_id"
    t.bigint "imported_file_id", null: false
    t.integer "balance_cents"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["budgeted_line_item_id"], name: "index_transactions_on_budgeted_line_item_id"
    t.index ["imported_file_id"], name: "index_transactions_on_imported_file_id"
  end

  create_table "user_entered_balances", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "transaction_id"
    t.integer "balance_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_user_entered_balances_on_account_id"
    t.index ["transaction_id"], name: "index_user_entered_balances_on_transaction_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "budgeted_line_items", "accounts"
  add_foreign_key "imported_files", "accounts"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "budgeted_line_items"
  add_foreign_key "transactions", "imported_files"
end
