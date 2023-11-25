class CreateBuyers < ActiveRecord::Migration[7.1]
  def change
    create_table :buyers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.text :payment_method, null: true
      t.text :address, null: true

      t.timestamps
    end
  end
end
