require 'rails_helper'

RSpec.describe StockItem, type: :model do
  before do
    @product = Product.create(name: 'Product X', cost_price: 10.0)
    @store = Store.create(name: 'Store X', address: 'Rua X')
    @stock_item = subject.class.new(product_id: @product.id, store_id: @store.id, quantity: 150.0)
  end
  context 'invalid params' do
    it 'product_id is nil' do
      @stock_item.product_id = nil
      expect(@stock_item).to_not be_valid
    end
    it 'store_id is nil' do
      @stock_item.store_id = nil
      expect(@stock_item).to_not be_valid
    end
    it 'product_id and store_id not unique' do
      StockItem.create(product_id: @product.id, store_id: @store.id, quantity: 150.0)
      expect(@stock_item).to_not be_valid
    end
  end
  context 'valid stockitem' do
    it { expect(@stock_item).to be_valid }
  end
end
