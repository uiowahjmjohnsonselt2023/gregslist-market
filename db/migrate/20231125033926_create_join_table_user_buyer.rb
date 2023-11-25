class CreateJoinTableUserBuyer < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :buyers do |t|
      t.index [:user_id, :buyer_id]
    end
  end
end
