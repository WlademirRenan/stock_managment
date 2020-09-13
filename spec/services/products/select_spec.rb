require 'rails_helper'

RSpec.describe Services::Products::Select, type: :model do
  before do
    @product = Product.create(name: 'Product X', cost_price: 10.0)
    @product_select = subject.class.new(product_id: @product.id)
  end
  context 'when date invalid' do
    it 'product_id is null' do
      @product_select.product_id = nil
      @product_select.call
      expect(@product_select.errors).to eq ['product_id is required']
    end

    it 'product_id not exists' do
      @product_select.product_id = 101010101010
      @product_select.call
      expect(@product_select.errors).to eq ['product not found']
    end
  end
  context 'when valid params' do
    it 'return param data with parameters of product selected' do
      data = { cost_price: 10.0, name: 'Product X', product_id: @product.id }
      @product_select.call
      expect(@product_select.errors).to eq []
      expect(@product_select.data).to eq data
    end
  end
end
