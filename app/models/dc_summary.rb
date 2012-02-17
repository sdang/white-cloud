class DcSummary < ActiveRecord::Base
  encrypt_with_public_key :first_name, :last_name, :dob, :diagnoses, :condition, 
        :diet, :activity, :discharge_orders, :hospital_course, :hpi, :follow_up, :dc_instructions,
        :key_pair => File.join(Rails.root, 'config', 'keypair.pem')
        
  validates_presence_of :first_name, :last_name
  validates_numericality_of :mrn, :message => "must be numbers only"
  
  has_many :prescriptions
  
  def finalize!
    # validate everything is complete for a final discharge, if valid set the finalized_at and finalized (bool) parameters
    
  end
  
  def user
    if self.read_attribute(:last_update_user)
      return User.find(self.read_attribute(:last_update_user))
    else
      return User.find(self.read_attribute(:created_user_id))
    end
  end
  
  def patient_name(pw)
    return self.first_name.decrypt(pw) + " " + self.last_name.decrypt(pw)
  end
  
  def prescriptions_to_print
    self.prescriptions.where("sig <> ? and quantity <> ?", "", "")
  end
  
  def primary_diagnosis(pw)
    if self.diagnoses.decrypt(pw)
      return self.diagnoses.decrypt(pw).match(/^(.*)$/).to_s
    else
      return ""
    end
  end
  
end