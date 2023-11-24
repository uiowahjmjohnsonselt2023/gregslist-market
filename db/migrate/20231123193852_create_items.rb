class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.references :seller, null: false, foreign_key: true
      t.date :listing_date
      t.decimal :listed_price

      t.timestamps
    end
  end
end
