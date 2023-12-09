class CreateJoinTableUserSeller < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :sellers do |t|
      t.index %i[user_id seller_id]
      # t.index [:seller_id, :user_id]
    end
  end
end
