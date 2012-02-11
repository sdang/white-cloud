class CreateDcSummaries < ActiveRecord::Migration
  def change
    create_table :dc_summaries do |t|

      # internal tracking
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :created_user_id
      t.integer :last_update_user_id
      t.datetime :finalized_at
      t.boolean :finalized
      
      # administrative data
      t.string :mrn
      t.date :admit_date
      t.date :discharge_date
      t.string :attending
      t.string :resident
      t.string :intern
      t.string :medical_student
      
      # protected health information
      t.binary :first_name
      t.binary :first_name_key
      t.binary :first_name_iv
      
      t.binary :last_name
      t.binary :last_name_key
      t.binary :last_name_iv
      
      t.binary :dob
      t.binary :dob_key
      t.binary :dob_iv
      
      t.binary :diagnoses
      t.binary :diagnoses_key
      t.binary :diagnosis_iv
      
      t.binary :condition
      t.binary :condition_key
      t.binary :condition_iv
      
      t.binary :diet
      t.binary :diet_key
      t.binary :diet_iv
      
      t.binary :activity
      t.binary :activity_key
      t.binary :activity_iv
      
      t.binary :discharge_orders
      t.binary :discharge_orders_key
      t.binary :discharge_orders_iv
      
      t.binary :hospital_course
      t.binary :hospital_course_key
      t.binary :hospital_course_iv
      
      t.binary :hpi
      t.binary :hpi_key
      t.binary :hpi_iv
      
      t.binary :follow_up
      t.binary :follow_up_key
      t.binary :follow_up_iv
      
      t.binary :dc_instructions
      t.binary :dc_instructions_key
      t.binary :dc_instructions_iv
    end
  end
  
end
