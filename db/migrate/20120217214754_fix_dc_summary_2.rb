class FixDcSummary2 < ActiveRecord::Migration
  def up
    add_column :dc_summaries, :chief_complaint, :binary
    add_column :dc_summaries, :chief_complaint_iv, :binary
    add_column :dc_summaries, :chief_complaint_key, :binary
    
    add_column :dc_summaries, :one_liner, :binary
    add_column :dc_summaries, :one_liner_iv, :binary
    add_column :dc_summaries, :one_liner_key, :binary
    
    add_column :dc_summaries, :procedures, :binary
    add_column :dc_summaries, :procedures_iv, :binary
    add_column :dc_summaries, :procedures_key, :binary
    
    add_column :dc_summaries, :service, :binary
    add_column :dc_summaries, :service_iv, :binary
    add_column :dc_summaries, :service_key, :binary
    
    add_column :dc_summaries, :disposition, :binary
    add_column :dc_summaries, :disposition_iv, :binary
    add_column :dc_summaries, :disposition_key, :binary
  end

  def down
    remove_column :dc_summaries, :chief_complaint
    remove_column :dc_summaries, :chief_complaint_iv
    remove_column :dc_summaries, :chief_complaint_key

    remove_column :dc_summaries, :one_liner
    remove_column :dc_summaries, :one_liner_iv
    remove_column :dc_summaries, :one_liner_key

    remove_column :dc_summaries, :procedures
    remove_column :dc_summaries, :procedures_iv
    remove_column :dc_summaries, :procedures_key
    remove
    remove_column :dc_summaries, :service
    remove_column :dc_summaries, :service_iv
    remove_column :dc_summaries, :service_key

    remove_column :dc_summaries, :disposition
    remove_column :dc_summaries, :disposition_iv
    remove_column :dc_summaries, :disposition_key
  end
end
