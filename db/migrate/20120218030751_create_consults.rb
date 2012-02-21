class CreateConsults < ActiveRecord::Migration
  def change
    create_table :consults do |t|
      t.binary :service
      t.binary :service_iv
      t.binary :service_key
      t.binary :reason
      t.binary :reason_iv
      t.binary :reason_key
      t.integer :dc_summary_id

      t.timestamps
    end
  end
end
