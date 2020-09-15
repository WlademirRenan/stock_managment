module Services
  module StockItems
    class RemoveQuantity
      def initialize(params = {})
        @product_id = params[:product_id]
        @store_id = params[:store_id]
        @quantity = params[:quantity]
        @errors = []
      end

      attr_accessor :product_id, :store_id, :quantity, :errors

      def call
        validate_fields
        return unless @errors.empty?

        stock_item = ::StockItem.find_by_product_id_and_store_id(@product_id, @store_id)
        if stock_item
          process_quantity(stock_item)
        else
          @errors << 'stock_item not found'
        end
      end

      def process_quantity(stock_item)
        StockItem.transaction do
          stock_item.quantity -= @quantity
          stock_item.save
        end
      end

      def validate_fields
        @errors << 'product_id is required' if @product_id.blank?
        @errors << 'store_id is required' if @store_id.blank?
        @errors << 'quantity is required' if @quantity.blank?
        @errors << 'quantity must be a positive number' if @quantity.to_f.negative?
      end
    end
  end
end
