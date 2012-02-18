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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120218030751) do

  create_table "admin_sign_outs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "resident_user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consults", :force => true do |t|
    t.binary   "service"
    t.binary   "service_iv"
    t.binary   "service_key"
    t.binary   "reason"
    t.binary   "reason_iv"
    t.binary   "reason_key"
    t.integer  "dc_summary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dc_summaries", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_user_id"
    t.integer  "last_update_user_id"
    t.datetime "finalized_at"
    t.boolean  "finalized",            :default => false
    t.string   "mrn"
    t.date     "admit_date"
    t.date     "discharge_date"
    t.string   "attending"
    t.string   "resident"
    t.string   "intern"
    t.string   "medical_student"
    t.binary   "first_name"
    t.binary   "first_name_key"
    t.binary   "first_name_iv"
    t.binary   "last_name"
    t.binary   "last_name_key"
    t.binary   "last_name_iv"
    t.binary   "dob_key"
    t.binary   "dob_iv"
    t.binary   "diagnoses"
    t.binary   "diagnoses_key"
    t.binary   "diagnoses_iv"
    t.binary   "condition"
    t.binary   "condition_key"
    t.binary   "condition_iv"
    t.binary   "diet"
    t.binary   "diet_key"
    t.binary   "diet_iv"
    t.binary   "activity"
    t.binary   "activity_key"
    t.binary   "activity_iv"
    t.binary   "discharge_orders"
    t.binary   "discharge_orders_key"
    t.binary   "discharge_orders_iv"
    t.binary   "hospital_course"
    t.binary   "hospital_course_key"
    t.binary   "hospital_course_iv"
    t.binary   "hpi"
    t.binary   "hpi_key"
    t.binary   "hpi_iv"
    t.binary   "follow_up"
    t.binary   "follow_up_key"
    t.binary   "follow_up_iv"
    t.binary   "dc_instructions"
    t.binary   "dc_instructions_key"
    t.binary   "dc_instructions_iv"
    t.date     "dob"
    t.binary   "chief_complaint"
    t.binary   "chief_complaint_iv"
    t.binary   "chief_complaint_key"
    t.binary   "one_liner"
    t.binary   "one_liner_iv"
    t.binary   "one_liner_key"
    t.binary   "procedures"
    t.binary   "procedures_iv"
    t.binary   "procedures_key"
    t.binary   "service"
    t.binary   "service_iv"
    t.binary   "service_key"
    t.binary   "disposition"
    t.binary   "disposition_iv"
    t.binary   "disposition_key"
  end

  create_table "prescriptions", :force => true do |t|
    t.integer  "dc_summary_id"
    t.string   "drug"
    t.string   "quantity"
    t.string   "sig"
    t.integer  "refills",       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reminder_lists", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reminders", :force => true do |t|
    t.string   "mrn"
    t.string   "reminder"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "remind_time"
    t.integer  "reminder_list_id"
    t.integer  "user_id"
    t.boolean  "completed",         :default => false
    t.string   "contact_number"
    t.datetime "last_notification"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "authorized",                            :default => false
    t.boolean  "admin",                                 :default => false
    t.string   "pager_number"
    t.text     "sms_number"
    t.string   "preferences"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
