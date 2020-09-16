require 'rails_helper'

RSpec.describe 'Product', type: :request do
  before do
    @product = Product.create(name: 'Product X', cost_price: 10.0)
  end
  context 'create' do
    context 'when success' do
      it 'return status 201' do
        params = { name: 'Product X', cost_price: 10.0 }

        post '/api/v1/products', params: params

        expect(response.status).to eq 201
        expect(JSON.parse(response.body)['errors']).to eq []
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { name: 'Product X', cost_price: nil }

        post '/api/v1/products', params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq ['cost_price is required']
      end
    end
  end
  context 'delete' do
    context 'when success' do
      it 'return status 201' do
        params = { product_id: @product.id }

        delete "/api/v1/products/#{@product.id}", params: params

        expect(response.status).to eq 201
        expect(JSON.parse(response.body)['errors']).to eq []
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { name: 'Product X' }

        delete "/api/v1/products/#{@product.id}", params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq ['product_id is required']
      end
    end
  end
  context 'select' do
    context 'when success' do
      it 'return status 201' do
        params = { product_id: @product.id }
        data = { cost_price: 10.0, name: 'Product X', product_id: @product.id }

        get "/api/v1/products/#{@product.id}", params: params

        expect(response.status).to eq 201
        expect(JSON.parse(response.body)['errors']).to eq []
        expect(JSON.parse(response.body)['data'].symbolize_keys).to eq data
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { name: 'Product X' }

        get "/api/v1/products/#{@product.id}", params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq ['product_id is required']
      end
    end
  end
  context 'update' do
    context 'when success' do
      it 'return status 201' do
        params = { product_id: @product.id, cost_price: 15.0, name: 'Product X1' }

        patch "/api/v1/products/#{@product.id}", params: params

        expect(response.status).to eq 201
        expect(JSON.parse(response.body)['errors']).to eq []
        expect(JSON.parse(response.body)['name']).to eq 'Product X1'
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { name: nil }
        errors = ['product_id is required', 'name or cost_price must be present']

        patch "/api/v1/products/#{@product.id}", params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq errors
      end
    end
  end
end
