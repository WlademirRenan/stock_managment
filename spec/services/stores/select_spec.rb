require 'rails_helper'

RSpec.describe Services::Stores::Select, type: :model do
  before do
    @store = Store.create(name: 'Store X', address: 'Rua X')
    @store_select = subject.class.new(store_id: @store.id)
  end
  context 'when date invalid' do
    it 'store_id is null' do
      @store_select.store_id = nil
      @store_select.call
      expect(@store_select.errors).to eq ['store_id is required']
    end

    it 'store_id not exists' do
      @store_select.store_id = 101010101010
      @store_select.call
      expect(@store_select.errors).to eq ['store not found']
    end
  end
  context 'when valid params' do
    it 'return param data with parameters of store selected' do
      data = { address: 'Rua X', name: 'Store X', store_id: @store.id }
      @store_select.call
      expect(@store_select.errors).to eq []
      expect(@store_select.data).to eq data
    end
  end
end
