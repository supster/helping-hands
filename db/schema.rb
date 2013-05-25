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

ActiveRecord::Schema.define(:version => 20130525011242) do

  create_table "action_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "actions", :force => true do |t|
    t.integer  "state_id"
    t.string   "name"
    t.string   "description"
    t.integer  "next_state_id"
    t.integer  "sub_workflow_id"
    t.integer  "order_no"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "save_attr"
  end

  add_index "actions", ["state_id"], :name => "index_actions_on_state_id"

  create_table "agencies", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "case_workflow_values", :force => true do |t|
    t.integer  "user_case_id"
    t.integer  "workflow_id"
    t.integer  "state_id"
    t.integer  "action_id"
    t.string   "save_attr"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "case_workflow_values", ["action_id"], :name => "index_case_workflow_values_on_action_id"
  add_index "case_workflow_values", ["state_id"], :name => "index_case_workflow_values_on_state_id"
  add_index "case_workflow_values", ["user_case_id"], :name => "index_case_workflow_values_on_user_case_id"
  add_index "case_workflow_values", ["workflow_id"], :name => "index_case_workflow_values_on_workflow_id"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "url"
    t.string   "email"
    t.integer  "agency_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "locations", ["agency_id"], :name => "index_locations_on_agency_id"

  create_table "program_criteria", :force => true do |t|
    t.integer  "program_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "program_criteria", ["program_id"], :name => "index_program_criteria_on_program_id"

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.integer  "agency_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "programs", ["agency_id"], :name => "index_programs_on_agency_id"

  create_table "programs_services", :id => false, :force => true do |t|
    t.integer "program_id"
    t.integer "service_id"
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "states", :force => true do |t|
    t.integer  "workflow_id"
    t.string   "name"
    t.text     "description"
    t.string   "form_name"
    t.string   "form_param"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "action_type_id"
  end

  add_index "states", ["workflow_id"], :name => "index_states_on_workflow_id"

  create_table "user_cases", :force => true do |t|
    t.string   "case_token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_cases", ["case_token"], :name => "index_user_cases_on_case_token"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "age"
    t.date     "date_of_birth"
    t.integer  "household_size"
    t.float    "monthly_income"
    t.boolean  "citizen"
    t.boolean  "immigrant"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "workflows", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "area_id"
    t.integer  "start_state_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "service_id"
  end

  add_index "workflows", ["area_id"], :name => "index_workflows_on_area_id"

end
