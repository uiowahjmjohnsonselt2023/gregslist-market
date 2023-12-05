class CreatePurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :purchases do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :total_price

      t.timestamps
    end
  end
end
