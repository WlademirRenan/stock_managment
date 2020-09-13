module Services
  module Products
    class Delete
      def initialize(params = {})
        @product_id = params[:product_id]
        @errors = []
      end

      attr_accessor :product_id, :errors

      def call
        validate_fields
        return unless @errors.empty?

        product = ::Product.find_by_id(@product_id)
        if product
          product.delete
        else
          @errors << 'product not found'
        end
      end

      def validate_fields
        @errors << 'product_id is required' if @product_id.blank?
      end
    end
  end
end
