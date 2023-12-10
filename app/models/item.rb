class Item < ApplicationRecord
  belongs_to :seller
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_one_attached :image

  def category_names
    categories.map { |cat| cat.name }
  end

  def owned_by?(user)
    seller.users.include? user
  end

  def listed?
    seller.exists? && seller.listed?
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[description listed_price name]
  end
end
