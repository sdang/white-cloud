class DcSummary < ActiveRecord::Base
  encrypt_with_public_key :first_name, :last_name, :diagnoses, :condition, 
        :diet, :activity, :discharge_orders, :hospital_course, :hpi, :follow_up, :dc_instructions,
        :key_pair => File.join(Rails.root, 'config', 'keypair.pem')
        
  validates_presence_of :first_name, :last_name, :dob
  validates_numericality_of :mrn, :message => "must be numbers only"
  
  has_many :prescriptions
  
  attr_accessor :missing_fields
  
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
  
  def prescriptions_in_medlish(pw)
    self.prescriptions.collect { |x| x.in_medlish }.join("\n") 
  end
  
  def prescriptions_in_english(pw)
    self.prescriptions.collect { |x| x.in_english }.join("\n")
  end
  
  def can_be_finalized?
    self.missing_fields = []
    self.missing_fields.push("Attending") if self.attending.blank?
    self.missing_fields.push("Resident") if self.resident.blank?
    self.missing_fields.push("Discharge Diagnoses") if self.diagnoses.blank?
    self.missing_fields.push("History of Present Illness") if self.hpi.blank?
    self.missing_fields.push("Hospital Course") if self.hospital_course.blank?
    self.missing_fields.push("Date of Admission") unless self.admit_date
    self.missing_fields.push("Date of Discharge") unless self.discharge_date
    self.missing_fields.push("Chief Compliant") if self.chief_complaint.blank?
    self.missing_fields.push("Condition") if self.condition.blank?
    self.missing_fields.push("Disposition") if self.disposition.blank?
    self.missing_fields.push("Diet") if self.diet.blank?
    self.missing_fields.push("Activity") if self.activity.blank?

    if self.missing_fields.size == 0
      return true
    else
      return false
    end
  end
  
end