# Table for all store page information
class Seller < ApplicationRecord
  has_many :items
  has_and_belongs_to_many :users
  has_one_attached :image

  before_save { self.address = address.downcase }
  validates :name, presence: true, length: { maximum: 100 }
end
