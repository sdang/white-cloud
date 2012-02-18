class AddPriorityToConsults < ActiveRecord::Migration
  def up
    add_column :consults, :priority, :string
    add_column :consults, :appointment_time, :datetime
    add_column :consults, :contact_after_seen, :boolean, :default => false
  end
  
  def down
    remove_column :consults, :priority
    remove_column :consults, :appointment_time
    remove_column :consults, :contact_after_seen
  end
  
end
