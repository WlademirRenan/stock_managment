require 'rails_helper'

RSpec.describe 'Stock Item', type: :request do
  before do
    @product = Product.create(name: 'Product X', cost_price: 10.0)
    @product2 = Product.create(name: 'Product X2', cost_price: 2.0)
    @store = Store.create(name: 'Store X', address: 'Rua X')
    @stock_item = StockItem.create(product_id: @product.id, store_id: @store.id, quantity: 150.0)
  end
  context 'create' do
    context 'when success' do
      it 'return status 201' do
        params = { product_id: @product2.id, store_id: @store.id, quantity: 10.0 }

        post '/api/v1/stock_items', params: params

        expect(response.status).to eq 201
        expect(JSON.parse(response.body)['errors']).to eq []
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { name: 'Product X' }
        errors = ['product_id is required', 'store_id is required', 'quantity is required']

        post '/api/v1/stock_items', params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq errors
      end
    end
  end
  context 'Add quantity' do
    context 'when success' do
      it 'return status 201' do
        params = { product_id: @product.id, store_id: @store.id, quantity: 10.0 }
        item = StockItem.where(product_id: @product.id, store_id: @store.id).take

        expect(item.quantity).to eq 150.0

        patch '/api/v1/stock_items', params: params

        expect(response.status).to eq 201
        expect(JSON.parse(response.body)['errors']).to eq []
        expect(item.reload.quantity).to eq 160.0
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { product_id: @product.id, store_id: 1010101011, quantity: 10.0 }
        errors = ['stock_item not found']

        patch '/api/v1/stock_items', params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq errors
      end
    end
  end
  context 'Remove quantity' do
    context 'when success' do
      it 'return status 201' do
        params = { product_id: @product.id, store_id: @store.id, quantity: 10.0 }
        item = StockItem.where(product_id: @product.id, store_id: @store.id).take

        expect(item.quantity).to eq 150.0

        delete '/api/v1/stock_items', params: params

        expect(response.status).to eq 201
        expect(JSON.parse(response.body)['errors']).to eq []
        expect(item.reload.quantity).to eq 140.0
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { product_id: @product.id, store_id: 1010101011, quantity: 10.0 }
        errors = ['stock_item not found']

        delete '/api/v1/stock_items', params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq errors
      end
    end
  end
end
