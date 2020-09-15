class Product < ApplicationRecord
  validates :name, :cost_price, presence: true
  validates :name, uniqueness: true
end
