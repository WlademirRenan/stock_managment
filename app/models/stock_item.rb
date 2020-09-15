class StockItem < ApplicationRecord
  belongs_to :product
  belongs_to :store

  validates :quantity, presence: true
  validates :product, uniqueness: { scope: [:product_id, :store_id] }
end
