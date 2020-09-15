class Api::V1::StockItemsController < Api::V1::ApiController

  # POST /api/v1/stock_items
  def create
    @stock_item = Services::StockItems::Create.new(product_params)
    @stock_item.call
    if @stock_item.errors.empty?
      render json: @stock_item, status: :created
    else
      render json: @stock_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/stock_items
  def show
    @stock_item = Services::StockItems::AddQuantity.new(product_params)
    @stock_item.call
    if @stock_item.errors.empty?
      render json: @stock_item, status: :created
    else
      render json: @stock_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/stock_items
  def update
    @stock_item = Services::StockItems::RemoveQuantity.new(product_params)
    @stock_item.call
    if @stock_item.errors.empty?
      render json: @stock_item, status: :created
    else
      render json: @stock_item.errors, status: :unprocessable_entity
    end
  end

  private
  # Only allow a trusted parameter "white list" through.
  def product_params
    params.permit(:quantity, :product_id, :store_id)
  end
end
