# frozen_string_literal: true

class Buyer < ApplicationRecord
  belongs_to :user
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :payment_method, presence: true, length: { maximum: 16 }
end
