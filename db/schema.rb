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

ActiveRecord::Schema.define(version: 20170330200242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "number"
    t.string   "street"
    t.string   "apartment"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "appointment_settings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "time_zone"
    t.time     "booking_cutoff_time"
    t.time     "booking_cutoff_unit"
    t.time     "buffer_time"
    t.time     "day_start_time"
    t.time     "day_end_time"
    t.float    "billing_rate"
    t.time     "min_length"
    t.time     "max_length"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.time     "start"
    t.time     "end"
    t.integer  "status"
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.date     "date"
    t.boolean  "paid"
    t.string   "doctor_goog_event_id"
    t.string   "patient_goog_event_id"
    t.string   "title"
    t.integer  "cpt_code"
    t.integer  "event_type"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "stripe_token"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "license_number"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  end

  create_table "complaints", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "dashboards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "days", force: :cascade do |t|
    t.time     "start"
    t.time     "end"
    t.boolean  "open"
    t.text     "schedule_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.date     "date"
    t.integer  "day_num"
    t.integer  "user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id"
  end

  create_table "google_calendar_wrappers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inquiries", force: :cascade do |t|
    t.integer  "lead_id"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.string   "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.text     "recipient_first_name"
    t.text     "recipient_last_name"
    t.datetime "sent_at"
  end

  create_table "leads", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.string   "anonymous_id", default: [],              array: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.string  "unsubscriber_type"
    t.integer "unsubscriber_id"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree
  end

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.string   "sender_type"
    t.integer  "sender_id"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.string   "notified_object_type"
    t.integer  "notified_object_id"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
    t.index ["type"], name: "index_mailboxer_notifications_on_type", using: :btree
  end

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.string   "receiver_type"
    t.integer  "receiver_id"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "is_delivered",               default: false
    t.string   "delivery_method"
    t.string   "message_id"
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "practice_doctors", force: :cascade do |t|
    t.integer  "practice_id"
    t.integer  "doctor_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "practices", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_practices_on_slug", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.date     "dob"
    t.string   "phone"
    t.string   "primary_physician"
    t.string   "primary_physicion_phone"
    t.string   "current_therapist"
    t.string   "therapist_phone"
    t.string   "sex"
    t.text     "exercise_frequency"
    t.string   "exercise_types"
    t.text     "allergies"
    t.text     "current_medications"
    t.text     "diagnoses"
    t.text     "past_medications"
    t.text     "med_conditions"
    t.text     "surgeries"
    t.text     "past_physicians"
    t.text     "dates_treate"
    t.boolean  "adopted"
    t.string   "adopted_age"
    t.text     "mother_rel"
    t.text     "father_rel"
    t.text     "siblings_and_ages"
    t.string   "married"
    t.string   "divorced"
    t.string   "d_age"
    t.string   "remarry"
    t.string   "remarry_age"
    t.string   "caretaker"
    t.string   "home_location"
    t.text     "family_med"
    t.text     "family_mental"
    t.text     "family_treatments"
    t.text     "move"
    t.text     "independence"
    t.text     "family_death"
    t.text     "suicide"
    t.text     "neglect"
    t.text     "trauma"
    t.text     "abuse"
    t.text     "education"
    t.string   "ed_date"
    t.string   "ed_location"
    t.string   "military"
    t.text     "military_location"
    t.text     "military_dates"
    t.string   "rank"
    t.string   "work_status"
    t.string   "marriage_count"
    t.text     "children"
    t.text     "child_birthdays"
    t.text     "child_relationship"
    t.text     "living_situation"
    t.boolean  "arrested"
    t.text     "arrested_details"
    t.boolean  "alcohol"
    t.boolean  "heroin"
    t.boolean  "ecstasy"
    t.boolean  "tobacco"
    t.boolean  "methapmphetamines"
    t.boolean  "methadone"
    t.boolean  "marijuana"
    t.boolean  "cocaine"
    t.boolean  "tranquilizers"
    t.boolean  "lsd"
    t.boolean  "stimulants"
    t.boolean  "pain_killers"
    t.boolean  "caffeine"
    t.boolean  "prescription_drugs"
    t.datetime "marriage_date"
    t.datetime "divorced_date"
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "status"
    t.string   "token"
    t.index ["doctor_id", "patient_id"], name: "index_relationships_on_doctor_id_and_patient_id", unique: true, using: :btree
    t.index ["doctor_id"], name: "index_relationships_on_doctor_id", using: :btree
    t.index ["patient_id"], name: "index_relationships_on_patient_id", using: :btree
  end

  create_table "resources", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "slots", force: :cascade do |t|
    t.integer  "day_id"
    t.time     "start_time"
    t.time     "min_length"
    t.time     "max_length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "stripe_token"
    t.string   "plan"
    t.datetime "valid_until"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "todo_items", force: :cascade do |t|
    t.string   "title"
    t.datetime "deadline"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "todo_list_id"
    t.text     "description"
    t.boolean  "completed",    default: false, null: false
    t.index ["todo_list_id"], name: "index_todo_items_on_todo_list_id", using: :btree
  end

  create_table "todo_lists", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_todo_lists_on_user_id", using: :btree
  end

  create_table "user_complaints", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "complaint_id"
    t.date     "start"
    t.date     "end"
    t.boolean  "repeat_experience"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",                default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "primary_phone"
    t.integer  "invitation_id"
    t.integer  "invitation_limit"
    t.string   "provider"
    t.string   "auth_id"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "refresh_token"
    t.string   "google_calendar_id"
    t.string   "stripe_id"
    t.string   "stripe_secret"
    t.string   "stripe_publishable"
    t.date     "birthday"
    t.string   "stripe_bank_token"
    t.string   "stripe_customer_token"
    t.text     "next_goog_cal_sync_token"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "profiles", "users"
  add_foreign_key "todo_items", "todo_lists"
  add_foreign_key "todo_lists", "users"
end
