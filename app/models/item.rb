class Item < ApplicationRecord
  belongs_to :seller
  belongs_to :category
  has_one_attached :image

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
