module Services
  module Stores
    class Update
      def initialize(params = {})
        @name = params[:name]
        @address = params[:address]
        @store_id = params[:store_id]
        @errors = []
      end

      attr_accessor :name, :address, :store_id, :errors

      def call
        validate_fields
        return unless @errors.empty?

        store = ::Store.find_by_id(@store_id)
        if store
          store.update(options)
        else
          @errors << 'store not found'
        end
      rescue => e
        @errors << e.message
      end

      def validate_fields
        @errors << 'store_id is required' if @store_id.blank?
        @errors << 'name or address must be present' if @name.blank? && @address.blank?
      end

      def options
        options = {}
        options[:name] = @name unless @name.blank?
        options[:address] = @address unless @address.blank?
        options
      end
    end
  end
end
