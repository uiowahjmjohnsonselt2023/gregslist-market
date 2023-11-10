class CreateSellers < ActiveRecord::Migration[7.1]
  def change
    create_table :sellers do |t|
      t.string :name
      t.text :description
      t.text :address

      t.timestamps
    end
  end
end
