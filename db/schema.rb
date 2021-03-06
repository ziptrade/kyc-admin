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

ActiveRecord::Schema.define(version: 20170718142116) do

  create_table "changes_kyc_change_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "id_number"
    t.string "id_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "states_states_id"
    t.string "type"
    t.bigint "kyc_attachment_id"
    t.text "comment"
    t.index ["kyc_attachment_id"], name: "index_changes_kyc_change_requests_on_kyc_attachment_id"
    t.index ["states_states_id"], name: "index_changes_kyc_change_requests_on_states_states_id"
  end

  create_table "dockets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "id_number"
    t.string "id_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dockets_kyc_attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "docket_id"
    t.bigint "kyc_attachment_id"
    t.index ["docket_id"], name: "index_dockets_kyc_attachments_on_docket_id"
    t.index ["kyc_attachment_id"], name: "index_dockets_kyc_attachments_on_kyc_attachment_id"
  end

  create_table "dockets_movement_restrictions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "docket_id"
    t.bigint "movement_restriction_id"
    t.index ["docket_id"], name: "index_dockets_movement_restrictions_on_docket_id"
    t.index ["movement_restriction_id"], name: "index_dockets_movement_restrictions_on_movement_restriction_id"
  end

  create_table "kyc_attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kycs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "state_id"
    t.index ["state_id"], name: "index_kycs_on_state_id"
  end

  create_table "movement_restrictions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "profiling_definition_id"
    t.integer "money_limit_cents", default: 0, null: false
    t.string "money_limit_currency", default: "USD", null: false
    t.bigint "period_id"
    t.index ["period_id"], name: "index_movement_restrictions_on_period_id"
    t.index ["profiling_definition_id"], name: "index_movement_restrictions_on_profiling_definition_id"
  end

  create_table "movements_movements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.datetime "moment"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "kyc_id"
    t.index ["kyc_id"], name: "index_movements_movements_on_kyc_id"
  end

  create_table "periods_periods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "times"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rejected_reasons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "previous_state_id"
    t.bigint "docket_id"
    t.string "reasons"
    t.bigint "reason_id"
    t.index ["docket_id"], name: "index_states_states_on_docket_id"
    t.index ["previous_state_id"], name: "index_states_states_on_previous_state_id"
    t.index ["reason_id"], name: "index_states_states_on_reason_id"
  end

  create_table "transgressions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "movement_id"
    t.bigint "movement_restriction_id"
    t.integer "surpassing_amount_cents", default: 0, null: false
    t.string "surpassing_amount_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movement_id"], name: "index_transgressions_on_movement_id"
    t.index ["movement_restriction_id"], name: "index_transgressions_on_movement_restriction_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "auth_token", null: false
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "changes_kyc_change_requests", "states_states", column: "states_states_id"
end
