class Prescription < ActiveRecord::Base
  belongs_to :dc_summary
  
  validates_presence_of :dc_summary_id, :drug
  
  def in_medlish
    self.drug ||= ""
    self.sig ||= ""
    self.quantity ||= ""
    self.refills ||= 0
    
    str = ""
    str << self.drug unless self.drug.empty?
    str << ", " + self.sig unless self.sig.empty?
    str << " qty: " + self.quantity unless self.quantity.empty?
    str << " refills: " + self.refills.to_s
    
    return str
  end
  
  def in_english
    str = self.in_medlish || ""
    
    # iterate through common med abbreviations and convert to english

    # routes
    str.gsub!(/\bp.?o.?\b/i, "by mouth ")                #po
    str.gsub!(/\bs.?c.?\b/i, "subcutaneous ")            #sc
    str.gsub!(/\bs.?q.?\b/i, "subcutaneous ")            #sq
    
    # frequencies
    str.gsub!(/\bq.?d.?\b/i, "daily ")                   #qd
    str.gsub!(/\bb.?i.?d\b/i, "two times daily ")        #bid
    str.gsub!(/\bt.?i.?d.?\b/i, "three times daily ")    #tid
    str.gsub!(/\bq.?i.?d.?\b/i, "four times daily ")     #qid
    str.gsub!(/\bq.?o.?d.?\b/i, "every other day ")      #qod
    str.gsub!(/\bq.?h.?s.?\b/i, "at bed time ")          #qhs
    str.gsub!(/\bq.?a.?c.?\b/i, "before meals ")         #qac
    str.gsub!(/\bq.?p.?m.?\b/i, "nightly ")              #qpm
    str.gsub!(/\bq.?a.?m.?\b/i, "in the morning ")       #qac
    
    # drug abbreviations
    str.gsub!(/\basa\b/i, "Aspirin ")                    #asa

    
    return str
  end
  
  def print?
    true if self.drug and self.sig and self.quantity
  end
  
end
