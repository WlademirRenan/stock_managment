require 'rails_helper'

RSpec.describe Store, type: :model do
  before do
    @store = subject.class.new(name: 'Store X', address: 'Rua X')
  end
  context 'invalid params' do
    it 'name is nil' do
      @store.name = nil
      expect(@store).to_not be_valid
    end
    it 'address is nil' do
      @store.address = nil
      expect(@store).to_not be_valid
    end
    it 'name not unique' do
      Store.create(name: 'Store X1', address: 'Rua X')
      @store.name = 'Store X1'
      expect(@store).to_not be_valid
    end
  end
  context 'valid product' do
    it { expect(@store).to be_valid }
  end
end
