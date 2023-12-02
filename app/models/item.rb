class Item < ApplicationRecord
  belongs_to :seller
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_one_attached :image

  def category_names
    categories.map { |cat| cat.name }
  end

  def owned_by?(user)
    seller.users.include? user
  end
end
