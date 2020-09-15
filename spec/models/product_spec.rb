require 'rails_helper'
RSpec.describe Product, type: :model do
  before do
    @product = subject.class.new(name: 'Product X', cost_price: 10.0)
  end
  context 'invalid params' do
    it 'name is nil' do
      @product.name = nil
      expect(@product).to_not be_valid
    end
    it 'cost_price is nil' do
      @product.cost_price = nil
      expect(@product).to_not be_valid
    end
    it 'name not unique' do
      Product.create(name: 'Product X1', cost_price: 10.0)
      @product.name = 'Product X1'
      expect(@product).to_not be_valid
    end
  end
  context 'valid product' do
    it { expect(@product).to be_valid }
  end
end
