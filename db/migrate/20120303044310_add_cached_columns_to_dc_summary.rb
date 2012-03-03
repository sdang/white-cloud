class AddCachedColumnsToDcSummary < ActiveRecord::Migration
  def up
    add_column :dc_summaries, :cached_summary, :binary
    add_column :dc_summaries, :cached_summary_iv, :binary
    add_column :dc_summaries, :cached_summary_key, :binary

    add_column :dc_summaries, :cached_instructions, :binary
    add_column :dc_summaries, :cached_instructions_iv, :binary
    add_column :dc_summaries, :cached_instructions_key, :binary
  end
  
  def down
    remove_column :dc_summaries, :cached_summary
    remove_column :dc_summaries, :cached_summary_iv
    remove_column :dc_summaries, :cached_summary_key

    remove_column :dc_summaries, :cached_instructions
    remove_column :dc_summaries, :cached_instructions_iv
    remove_column :dc_summaries, :cached_instructions_key
  end
end
