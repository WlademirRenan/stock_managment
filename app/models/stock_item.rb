class StockItem < ApplicationRecord
  belongs_to :product
  belongs_to :store
  def add_quantity(quantity)
    self.quantity += quantity
    self.save
  end

  def remove_quantity(quantity)
    self.quantity -= quantity
    self.save
  end

end
