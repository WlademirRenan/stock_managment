module Services
  module Products
    class Select
      def initialize(params = {})
        @data = {}
        @product_id = params[:product_id]
        @errors = []
      end

      attr_accessor :data, :product_id, :errors

      def call
        validate_fields
        return unless @errors.empty?

        product = ::Product.find_by_id(@product_id)
        if product
          @data[:product_id] = @product_id
          @data[:name] = product.name
          @data[:cost_price] = product.cost_price
        else
          @errors << 'product not found'
        end
      rescue => e
        @errors << e.message
      end

      def validate_fields
        @errors << 'product_id is required' if @product_id.blank?
      end

    end
  end
end
