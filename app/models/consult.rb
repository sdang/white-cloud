class Consult < ActiveRecord::Base
  belongs_to :dc_summary
  
  validates_presence_of :dc_summary_id, :service, :reason
  
  encrypt_with_public_key :service, :reason, :key_pair => File.join(Rails.root, 'config', 'keypair.pem')
  
end
