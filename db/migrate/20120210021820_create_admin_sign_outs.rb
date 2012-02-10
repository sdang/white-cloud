class CreateAdminSignOuts < ActiveRecord::Migration
  def change
    create_table :admin_sign_outs do |t|
      t.integer :user_id
      t.integer :resident_user_id
      t.string :name

      t.timestamps
    end
  end
end
