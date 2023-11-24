class Item < ApplicationRecord
    belongs_to :seller
    has_many :item_categories
    has_many :categories, through: :item_categories
end
