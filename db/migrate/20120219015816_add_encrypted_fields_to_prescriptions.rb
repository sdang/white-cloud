class AddEncryptedFieldsToPrescriptions < ActiveRecord::Migration

  def up
    # can't convert string to binary, so we gotta chuck the data
    remove_column :prescriptions, :drug
    remove_column :prescriptions, :sig
    
    add_column :prescriptions, :drug, :binary
    add_column :prescriptions, :drug_iv, :binary
    add_column :prescriptions, :drug_key, :binary

    add_column :prescriptions, :sig, :binary
    add_column :prescriptions, :sig_iv, :binary
    add_column :prescriptions, :sig_key, :binary        
  end
  
  def down
    remove_column :prescriptions, :drug
    remove_column :prescriptions, :drug_iv
    remove_column :prescriptions, :drug_key

    remove_column :prescriptions, :sig
    remove_column :prescriptions, :sig_iv
    remove_column :prescriptions, :sig_key
    
    add_column :prescriptions, :drug, :string
    add_column :prescriptions, :sig, :string
  end
end
