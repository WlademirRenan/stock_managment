module Services
  module StockItems
    class Create

      def initialize(params = {})
        @product_id = params[:product_id]
        @store_id = params[:store_id]
        @quantity = params[:quantity]
        @errors = []
      end

      attr_accessor :product_id, :store_id, :quantity, :errors

      def call
        validate_fields
        ::StockItem.create(product_id: @product_id, store_id: @store_id, quantity: @quantity) if @errors.empty?
      rescue => e
        @errors << e.message
      end

      def validate_fields
        @errors << 'product_id is required' if @product_id.blank?
        @errors << 'store_id is required' if @store_id.blank?
        @errors << 'quantity is required' if @quantity.blank?
      end
    end
  end
end
