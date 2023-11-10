class CreateSellers < ActiveRecord::Migration[7.1]
  def change
    create_table :sellers do |t|
      t.string :name, null: false
      t.text :description, null: true
      t.text :address, null: true

      t.timestamps
    end
  end
end
