class AddUserFields < ActiveRecord::Migration
  def up
    add_column :users, :pager_number, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :authorized, :boolean, :default => false
    add_column :users, :admin, :boolean, :default => false
    
    User.find(:all).each do |u|
      u.authorized = true
      u.admin = true
      u.save
    end
    
  end

  def down
    remove_column :users, :pager_number
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :authorized
    remove_column :users, :admin
  end
end
