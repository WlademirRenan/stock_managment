class Api::V1::StoresController < Api::V1::ApiController

  # POST /api/v1/stores
  def create
    @store = Services::Stores::Create.new(store_params)
    @store.call
    if @store.errors.empty?
      render json: @store, status: :created
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  # GET /api/v1/stores/:id
  def show
    @store = Services::Stores::Select.new(store_params)
    @store.call
    if @store.errors.empty?
      render json: @store, status: :created
    else
      render json: @store, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/stores/:id
  def update
    @store = Services::Stores::Update.new(store_params)
    @store.call
    if @store.errors.empty?
      render json: @store, status: :created
    else
      render json: @store, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/stores/:id
  def destroy
    @store = Services::Stores::Delete.new(store_params)
    @store.call
    if @store.errors.empty?
      render json: @store, status: :created
    else
      render json: @store, status: :unprocessable_entity
    end
  end

  private
  # Only allow a trusted parameter "white list" through.
  def store_params
    params.permit(:name, :address, :id, :store_id)
  end
end
