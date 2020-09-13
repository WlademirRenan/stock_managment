require 'rails_helper'

RSpec.describe Services::Stores::Delete, type: :model do
  before do
    @store = Store.create(name: 'Store X', address: 'Rua X')
    @store_delete = subject.class.new(store_id: @store.id)
  end
  context 'when date invalid' do
    it 'store_id is null' do
      @store_delete.store_id = nil
      @store_delete.call
      expect(@store_delete.errors).to eq ['store_id is required']
    end

    it 'store_id not exists' do
      @store_delete.store_id = 101010101010
      @store_delete.call
      expect(@store_delete.errors).to eq ['store not found']
    end
  end
  context 'when valid params' do
    it 'delete store' do
      expect(::Store.where(id: @store.id).count).to eq 1
      @store_delete.call
      expect(::Store.where(id: @store.id).count).to eq 0
    end
  end
end
