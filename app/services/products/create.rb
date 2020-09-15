module Services
  module Products
    class Create

      def initialize(params = {})
        @name = params[:name]
        @cost_price = params[:cost_price]
        @errors = []
      end

      attr_accessor :name, :cost_price, :errors

      def call
        validate_fields
        ::Product.create(name: @name, cost_price: @cost_price) if @errors.empty?
      rescue => e
        @errors << e.message
      end

      def validate_fields
        @errors << 'name is required' if @name.blank?
        @errors << 'cost_price is required' if @cost_price.blank?
      end

    end
  end
end
