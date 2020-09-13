module Services
  module Stores
    class Create
  
      def initialize(params = {})
        @name = params[:name]
        @address = params[:address]
        @errors = []
      end
  
      attr_accessor :name, :address, :errors
  
      def call
        validate_fields
        ::Store.create(name: @name, address: @address) if @errors.empty?
      end
  
      def validate_fields
        @errors << 'name is required' if @name.blank?
        @errors << 'address is required' if @address.blank?
      end
    end
  end
end
