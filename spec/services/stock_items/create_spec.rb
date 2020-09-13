require 'rails_helper'

RSpec.describe Services::StockItems::Create, type: :model do
  before do
    @product = Product.create(name: 'Product X', cost_price: 10.0)
    @store = Store.create(name: 'Store X', address: 'Rua X')
    @stock_item_create = subject.class.new(product_id: @product.id, store_id: @store.id, quantity: 150.0)
  end
  context 'when date invalid' do
    it 'product_id is null' do
      @stock_item_create.product_id = nil
      @stock_item_create.call
      expect(@stock_item_create.errors).to eq ['product_id is required']
    end

    it 'store is null' do
      @stock_item_create.store_id = nil
      @stock_item_create.call
      expect(@stock_item_create.errors).to eq ['store_id is required']
    end

    it 'quantity is null' do
      @stock_item_create.quantity = nil
      @stock_item_create.call
      expect(@stock_item_create.errors).to eq ['quantity is required']
    end

    it 'should return 3 errors' do
      subject.call
      expect(subject.errors.size).to eq 3
    end
  end
  context 'when valid product' do
    it 'create product' do
      expect(StockItem.count).to eq 0
      @stock_item_create.call
      expect(StockItem.count).to eq 1
    end
  end
end
