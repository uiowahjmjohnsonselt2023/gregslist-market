class AddUserRefToBuyer < ActiveRecord::Migration[7.1]
  def change
    add_reference :buyers, :user, null: false, foreign_key: true
  end
end
