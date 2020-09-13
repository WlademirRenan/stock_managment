module Services
  module Stores
    class Select
      def initialize(params = {})
        @data = {}
        @store_id = params[:store_id]
        @errors = []
      end

      attr_accessor :data, :store_id, :errors

      def call
        validate_fields
        return unless @errors.empty?

        store = ::Store.find_by_id(@store_id)
        if store
          @data[:store_id] = @store_id
          @data[:name] = store.name
          @data[:address] = store.address
        else
          @errors << 'store not found'
        end
      end

      def validate_fields
        @errors << 'store_id is required' if @store_id.blank?
      end

    end
  end
end
