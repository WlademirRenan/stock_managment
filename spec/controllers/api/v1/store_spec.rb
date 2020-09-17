require 'rails_helper'

RSpec.describe 'Store', type: :request do
  before do
    @store = Store.create(name: 'Store X', address: 'Rua X')
  end
  context 'create' do
    context 'when success' do
      it 'return status 201' do
        params = { name: 'Store X', address: 'Rua X' }

        post '/api/v1/stores', params: params

        expect(response.status).to eq 201
        expect(JSON.parse(response.body)['errors']).to eq []
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { name: 'Store X', address: nil }

        post '/api/v1/stores', params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq ['address is required']
      end
    end
  end
  context 'delete' do
    context 'when success' do
      it 'return status 201' do
        params = { store_id: @store.id }

        delete "/api/v1/stores/#{@store.id}", params: params

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['errors']).to eq []
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { name: 'Store X' }

        delete "/api/v1/stores/#{@store.id}", params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq ['store_id is required']
      end
    end
  end
  context 'select' do
    context 'when success' do
      it 'return status 201' do
        params = { store_id: @store.id }
        data = { address: 'Rua X', name: 'Store X', store_id: @store.id }

        get "/api/v1/stores/#{@store.id}", params: params

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['errors']).to eq []
        expect(JSON.parse(response.body)['data'].symbolize_keys).to eq data
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { name: 'Store X' }

        get "/api/v1/stores/#{@store.id}", params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq ['store_id is required']
      end
    end
  end
  context 'update' do
    context 'when success' do
      it 'return status 201' do
        params = { store_id: @store.id, address: 15.0, name: 'Store X1' }

        patch "/api/v1/stores/#{@store.id}", params: params

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['errors']).to eq []
        expect(JSON.parse(response.body)['name']).to eq 'Store X1'
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { name: nil }
        errors = ['store_id is required', 'name or address must be present']

        patch "/api/v1/stores/#{@store.id}", params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq errors
      end
    end
  end
end
