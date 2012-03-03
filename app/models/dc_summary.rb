class DcSummary < ActiveRecord::Base
  encrypt_with_public_key :first_name, :last_name, :diagnoses, :condition, 
        :diet, :activity, :discharge_orders, :hospital_course, :hpi, :follow_up, :dc_instructions,
        :chief_complaint, :one_liner, :procedures, :disposition, 
        :cached_summary, :cached_instructions,
        :key_pair => File.join(Rails.root, 'config', 'keypair.pem')
        
  validates_presence_of :first_name, :last_name, :dob
  validates_numericality_of :mrn, :message => "must be numbers only"
  
  has_many :prescriptions
  has_many :consults
  
  after_update :add_update_log_message
  after_create :add_create_log_message
  
  attr_accessor :missing_fields, :admin_override
  
  def user
    if self.read_attribute(:last_update_user_id)
      return User.find(self.read_attribute(:last_update_user_id))
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
    self.prescriptions.collect { |x| x.in_medlish(pw) }.join("\n") 
  end
  
  def prescriptions_in_english(pw)
    self.prescriptions.collect { |x| x.in_english(pw) }.join("\n")
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
  
  def summary(password)
    if self.cached_summary.decrypt(password).blank?
      # create the cache
      self.admin_override = true
      self.cached_summary = I18n.translate(:dc_summary, 
          :name =>  self.patient_name(password),
          :mrun => self.mrn,
          :service => self.service,
          :attending => self.attending,
          :resident => self.resident,
          :intern => self.intern,
          :medical_student => self.medical_student,
          :date_of_admission => self.admit_date.strftime("%m-%d-%Y"),
          :date_of_discharge => self.discharge_date.strftime("%m-%d-%Y"),
          :procedures => self.procedures.decrypt(password),
          :discharge_diagnoses => self.diagnoses.decrypt(password),
          :chief_complaint => self.chief_complaint.decrypt(password),
          :hpi => self.hpi.decrypt(password),
          :hospital_course => self.hospital_course.decrypt(password),
          :condition => self.condition.decrypt(password),
          :disposition => self.disposition.decrypt(password),
          :diet => self.diet.decrypt(password),
          :activity_level => self.activity.decrypt(password),
          :medications => self.prescriptions_in_medlish(password),
          :discharge_instructions => self.dc_instructions.decrypt(password),
          :follow_up => self.follow_up.decrypt(password))
      self.save
      self.admin_override = false
    end
    
    return self.cached_summary.decrypt(password)
  end
  
  def instructions(password)
    if self.cached_instructions.decrypt(password).blank?
      self.admin_override = true
      self.cached_instructions = I18n.translate(:patient_instructions, 
      	:name =>  self.patient_name(password),
      	:mrun => self.mrn,
      	:service => self.service,
      	:attending => self.attending,
      	:resident => self.resident,
      	:intern => self.intern,
      	:medical_student => self.medical_student,
      	:date_of_admission => self.admit_date.strftime("%m-%d-%Y"),
      	:date_of_discharge => self.discharge_date.strftime("%m-%d-%Y"),
      	:procedures => self.procedures.decrypt(password),
      	:discharge_diagnoses => self.diagnoses.decrypt(password),
      	:chief_complaint => self.chief_complaint.decrypt(password),
      	:hpi => self.hpi.decrypt(password),
      	:hospital_course => self.hospital_course.decrypt(password),
      	:condition => self.condition.decrypt(password),
      	:disposition => self.disposition.decrypt(password),
      	:diet => self.diet.decrypt(password),
      	:activity_level => self.activity.decrypt(password),
      	:medications => self.prescriptions_in_english(password),
      	:discharge_instructions => self.dc_instructions.decrypt(password),
      	:follow_up => self.follow_up.decrypt(password),
      	:discharge_orders => self.discharge_orders.decrypt(password))
      self.save
      self.admin_override = false
    end
    
    return self.cached_instructions.decrypt(password)
  end
  
  def readonly?
   # we have to actually read from the db to see if this is finalized
   # and not just a newly finalized record we're trying to save
   return false if self.new_record? and self.finalized == false
   return false if self.admin_override
   return true if DcSummary.find(self.id).read_attribute(:finalized)
  end
  
  def import_rx(pw)
    summary_to_import = self.find_summary_for_import
    
    # fail if no summary matched
    return false unless summary_to_import
    
    # fail if no prescriptions from last dc summary
    return false if summary_to_import.prescriptions.size == 0
    
    # update current dc_summary with new prescriptions
    summary_to_import.prescriptions.each do |rx|
      self.prescriptions.create(:drug => rx.drug.decrypt(pw), :sig => rx.sig.decrypt(pw), :quantity => 0)
    end
    str = "Imported " + summary_to_import.prescriptions.collect {|x| x.drug.decrypt(pw) }.join(", ") + " into this d/c summary"
    
    return str
  end
  
  def import_one_liner(pw)
    summary_to_import = self.find_summary_for_import
    
    return false unless summary_to_import
    return false if summary_to_import.one_liner.decrypt(pw).blank?
    return summary_to_import.one_liner.decrypt(pw)
  end
  
  def import_diagnoses(pw)
    summary_to_import = self.find_summary_for_import
    
    return false unless summary_to_import
    return false if summary_to_import.diagnoses.decrypt(pw).blank?
    return summary_to_import.diagnoses.decrypt(pw)
  end
  
  def find_summary_for_import
    return DcSummary.find(:all, :conditions => ["id <> ? AND finalized = ? AND mrn = ?", self.id, true, self.mrn], :order => "updated_at DESC", :limit => 1).first
  end
  
  private
  def add_update_log_message
    ApplicationLog.write("updated d/c summary for #{self.mrn}",1,self.last_update_user_id)
  end
  
  def add_create_log_message
    ApplicationLog.write("created d/c summary for #{self.mrn}", 1, self.created_user_id)
  end
  
end