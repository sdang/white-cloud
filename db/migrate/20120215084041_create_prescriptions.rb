class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
      t.integer :dc_summary_id
      t.string :drug
      t.string :quantity
      t.string :sig

      t.timestamps
    end
  end
end
