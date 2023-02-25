class FoodsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /foods
  def index
    # @foods = Food.all

    render json: @foods.map { |item|
      FoodSerializer.new(item).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  # GET /foods/1
  def show
    render json: FoodSerializer.new(@food).serializable_hash[:data][:attributes], status: :ok
  end

  # POST /foods
  def create
    @food = Food.new(food_params)

    if @food.save
      render json: FoodSerializer.new(@food).serializable_hash[:data][:attributes], status: :created
    else
      render json: @food.errors, status: :unprocessable_entity
    end
  end

  # DELETE /foods/1
  def destroy
    @food.destroy
    render json: { message: 'food deleted!' }, status: :no_content
  end

  private

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :unit, :price_per_unit)
  end
end
