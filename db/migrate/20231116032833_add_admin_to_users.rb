class AddAdminToUsers < ActiveRecord::Migration[7.1]
  def change
    # add_column :users, :admin, :boolean
    add_column :users, :admin, :boolean, default: false
  end
end
