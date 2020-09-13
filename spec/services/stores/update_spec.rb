require 'rails_helper'

RSpec.describe Services::Stores::Update, type: :model do
  before do
    @store = Store.create(name: 'Store X', address: 'Rua X')
    @store_update = subject.class.new(name: 'Store X1', address: 'Rua X1', store_id: @store.id)
  end
  context 'when date invalid' do
    it 'store_id is null' do
      @store_update.store_id = nil
      @store_update.call
      expect(@store_update.errors).to eq ['store_id is required']
    end

    it 'store_id not exists' do
      @store_update.store_id = 101010101010
      @store_update.call
      expect(@store_update.errors).to eq ['store not found']
    end

    it 'address and name is null' do
      @store_update.address = nil
      @store_update.name = nil
      @store_update.call
      expect(@store_update.errors).to eq ['name or address must be present']
    end
  end
  context 'when valid params' do
    it 'update name for store X1 and address for 12.0' do
      expect(@store.reload.name).to eq 'Store X'
      expect(@store.reload.address).to eq 'Rua X'
      @store_update.call
      expect(@store.reload.name).to eq 'Store X1'
      expect(@store.reload.address).to eq 'Rua X1'
    end
  end
end
