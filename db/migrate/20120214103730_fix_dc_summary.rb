class FixDcSummary < ActiveRecord::Migration
  def up
    # update reminders table
    change_column :dc_summaries, :finalized, :boolean, :default => false
    rename_column :dc_summaries, :diagnosis_iv, :diagnoses_iv
    
    DcSummary.find(:all).each do |dc|
      dc.update_attribute(:finalized, false)
    end
  end

  def down
    change_column :dc_summaries, :finalized, :boolean, :default => nil
    rename_column :dc_summaries, :diagnoses_iv, :diagnosis_iv
  end
end
