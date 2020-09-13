require 'rails_helper'

RSpec.describe Services::Products::Create, type: :model do
  before do
    @product_create = subject.class.new(name: 'Product X', cost_price: 10.0)
  end
  context 'when date invalid' do
    it 'name is null' do
      @product_create.name = nil
      @product_create.call
      expect(@product_create.errors).to eq ['name is required']
    end

    it 'cost_price is null' do
      @product_create.cost_price = nil
      @product_create.call
      expect(@product_create.errors).to eq ['cost_price is required']
    end

    it 'amount, destination_account_id and source_account_id' do
      subject.call
      expect(subject.errors.size).to eq 2
    end
  end
  context 'when valid product' do
    it 'create product' do
      expect(Product.count).to eq 0
      @product_create.call
      expect(Product.count).to eq 1
    end
  end
end
