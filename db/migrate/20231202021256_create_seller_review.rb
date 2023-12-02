class CreateSellerReview < ActiveRecord::Migration[7.1]
  def change
    create_table :seller_reviews do |t|
      t.references :seller, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :rating
      t.string :text

      t.timestamps
    end
  end
end
