require 'rails_helper'

RSpec.describe Services::Products::Update, type: :model do
  before do
    @product = Product.create(name: 'Product X', cost_price: 10.0)
    @product_update = subject.class.new(name: 'Product X1', cost_price: 12.0, product_id: @product.id)
  end
  context 'when date invalid' do
    it 'product_id is null' do
      @product_update.product_id = nil
      @product_update.call
      expect(@product_update.errors).to eq ['product_id is required']
    end

    it 'product_id not exists' do
      @product_update.product_id = 101010101010
      @product_update.call
      expect(@product_update.errors).to eq ['product not found']
    end

    it 'cost_price and name is null' do
      @product_update.cost_price = nil
      @product_update.name = nil
      @product_update.call
      expect(@product_update.errors).to eq ['name or cost_price must be present']
    end
  end
  context 'when valid params' do
    it 'update name for Product X1 and cost_price for 12.0' do
      expect(@product.reload.name).to eq 'Product X'
      expect(@product.reload.cost_price).to eq 10.0
      @product_update.call
      expect(@product.reload.name).to eq 'Product X1'
      expect(@product.reload.cost_price).to eq 12.0
    end
  end
end
