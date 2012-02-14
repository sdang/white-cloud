class DcSummary < ActiveRecord::Base
  encrypt_with_public_key :first_name, :last_name, :dob, :diagnoses, :condition, 
        :diet, :activity, :discharge_orders, :hospital_course, :hpi, :follow_up, :dc_instructions,
        :key_pair => File.join(Rails.root, 'config', 'keypair.pem')
        

  validates_presence_of :first_name, :last_name, :mrn
  
  def finalize!
    # validate everything is complete for a final discharge, if valid set the finalized_at and finalized (bool) parameters
    
  end
  
end