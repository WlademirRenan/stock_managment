require 'rails_helper'

RSpec.describe Services::StockItems::RemoveQuantity, type: :model do
  before do
    @product = Product.create(name: 'Product X', cost_price: 10.0)
    @store = Store.create(name: 'Store X', address: 'Rua X')
    @stock_item = StockItem.create(product_id: @product.id, store_id: @store.id, quantity: 150.0)
    @stock_item_remove = subject.class.new(product_id: @product.id, store_id: @store.id, quantity: 10.0)
  end
  context 'when date invalid' do
    it 'product_id is null' do
      @stock_item_remove.product_id = nil
      @stock_item_remove.call
      expect(@stock_item_remove.errors).to eq ['product_id is required']
    end

    it 'store is null' do
      @stock_item_remove.store_id = nil
      @stock_item_remove.call
      expect(@stock_item_remove.errors).to eq ['store_id is required']
    end

    it 'quantity is null' do
      @stock_item_remove.quantity = nil
      @stock_item_remove.call
      expect(@stock_item_remove.errors).to eq ['quantity is required']
    end

    it 'quantity is negative' do
      @stock_item_remove.quantity = -10
      @stock_item_remove.call
      expect(@stock_item_remove.errors).to eq ['quantity must be a positive number']
    end

    it 'stock_item not found not found' do
      @stock_item_remove.product_id = 101010101010101010
      @stock_item_remove.call
      expect(@stock_item_remove.errors).to eq ['stock_item not found']
    end

    it 'should return 3 errors' do
      subject.call
      expect(subject.errors.size).to eq 3
    end
  end
  context 'when valid product' do
    it 'create product' do
      expect(@stock_item.quantity).to eq 150
      @stock_item_remove.call
      expect(@stock_item.reload.quantity).to eq 140
    end
  end
end
