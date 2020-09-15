module Services
  module Products
    class Update
      def initialize(params = {})
        @name = params[:name]
        @cost_price = params[:cost_price]
        @product_id = params[:product_id]
        @errors = []
      end

      attr_accessor :name, :cost_price, :product_id, :errors

      def call
        validate_fields
        return unless @errors.empty?

        product = ::Product.find_by_id(@product_id)
        if product
          product.update(options)
        else
          @errors << 'product not found'
        end
      rescue => e
        @errors << e.message
      end

      def validate_fields
        @errors << 'product_id is required' if @product_id.blank?
        @errors << 'name or cost_price must be present' if @name.blank? && @cost_price.blank?
      end

      def options
        options = {}
        options[:name] = @name unless @name.blank?
        options[:cost_price] = @cost_price unless @cost_price.blank?
        options
      end
    end
  end
end
