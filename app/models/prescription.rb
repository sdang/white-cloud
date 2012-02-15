class Prescription < ActiveRecord::Base
  belongs_to :dc_summary
  
  validates_presence_of :dc_summary_id
end
