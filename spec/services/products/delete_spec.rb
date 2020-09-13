require 'rails_helper'

RSpec.describe Services::Products::Delete, type: :model do
  before do
    @product = Product.create(name: 'Product X', cost_price: 10.0)
    @product_delete = subject.class.new(product_id: @product.id)
  end
  context 'when date invalid' do
    it 'product_id is null' do
      @product_delete.product_id = nil
      @product_delete.call
      expect(@product_delete.errors).to eq ['product_id is required']
    end

    it 'product_id not exists' do
      @product_delete.product_id = 101010101010
      @product_delete.call
      expect(@product_delete.errors).to eq ['product not found']
    end
  end
  context 'when valid params' do
    it 'delete product' do
      expect(::Product.where(id: @product.id).count).to eq 1
      @product_delete.call
      expect(::Product.where(id: @product.id).count).to eq 0
    end
  end
end
