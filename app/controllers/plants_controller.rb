class PlantsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plants
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  # PATCH /plants/:id
  def update
    plant = find_plants
    plant.update(plant_params)
    render json: plant
  end

  # DESTROY /plants/:id
  def destroy
    plant = find_plants
    plant.destroy
    head :no_content
  end

  private

  def find_plants
    Plant.find_by(id: params[:id])
  end

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def render_not_found
    render json: { error: "plant not found" }, status: :not_found
  end
end
