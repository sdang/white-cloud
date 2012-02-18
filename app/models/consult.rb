class Consult < ActiveRecord::Base
  belongs_to :dc_summary
  
  validates_presence_of :dc_summary_id, :service, :reason
  
  encrypt_with_public_key :service, :reason, :key_pair => File.join(Rails.root, 'config', 'keypair.pem')

  def reason_for_yellow(pw)
    str = ""
    str += self.reason.decrypt(pw)
    str += "\n\nDischarge Medications: "
    str += self.dc_summary.prescriptions.collect { |x| x.drug + " " + x.sig }.join(", ")
  end
  
  def priority
    if self.read_attribute(:priority).blank?
      return "Routine"
    else
      return self.read_attribute(:priority)
    end
  end
  
end
