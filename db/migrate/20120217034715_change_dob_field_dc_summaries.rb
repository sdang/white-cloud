class ChangeDobFieldDcSummaries < ActiveRecord::Migration
  def up
    remove_column :dc_summaries, :dob
    add_column :dc_summaries, :dob, :date
  end

  def down
    remove_column :dc_summaries, :dob
    add_column :dc_summaries, :dob, :binary
  end
end
