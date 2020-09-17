class Api::V1::ProductsController < Api::V1::ApiController

  # POST /api/v1/products
  def create
    @product = Services::Products::Create.new(product_params)
    @product.call
    if @product.errors.empty?
      render json: @product, status: :created
    else
      render json: @product, status: :unprocessable_entity
    end
  end

  # GET /api/v1/products/:id
  def show
    @product = Services::Products::Select.new(product_params)
    @product.call
    if @product.errors.empty?
      render json: @product, status: :ok
    else
      render json: @product, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/products/:id
  def update
    @product = Services::Products::Update.new(product_params)
    @product.call
    if @product.errors.empty?
      render json: @product, status: :ok
    else
      render json: @product, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/products/:id
  def destroy
    @product = Services::Products::Delete.new(product_params)
    @product.call
    if @product.errors.empty?
      render json: @product, status: :ok
    else
      render json: @product, status: :unprocessable_entity
    end
  end

  private
  # Only allow a trusted parameter "white list" through.
  def product_params
    params.permit(:name, :cost_price, :id, :product_id)
  end
end
