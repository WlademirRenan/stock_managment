require 'rails_helper'

RSpec.describe Services::Stores::Create, type: :model do
  before do
    @store_create = subject.class.new(name: 'Store X', address: 'Rua X')
  end
  context 'when date invalid' do
    it 'name is null' do
      @store_create.name = nil
      @store_create.call
      expect(@store_create.errors).to eq ['name is required']
    end

    it 'address is null' do
      @store_create.address = nil
      @store_create.call
      expect(@store_create.errors).to eq ['address is required']
    end

    it 'should return 2 errors' do
      subject.call
      expect(subject.errors.size).to eq 2
    end
  end
  context 'when valid store' do
    it 'create store' do
      expect(Store.count).to eq 0
      @store_create.call
      expect(Store.count).to eq 1
    end
  end
end
