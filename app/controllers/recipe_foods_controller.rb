class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /recipe_foods
  def index
    # @recipe_foods = RecipeFood.all

    render json: @recipe_foods.map { |item|
      AppointmentSerializer.new(item).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  # POST /recipe_foods
  def create
    @recipe_food = RecipeFood.new(recipe_food_params)

    if @recipe_food.save
      render json: @recipe_food, status: :created, location: @recipe_food
    else
      render json: @recipe_food.errors, status: :unprocessable_entity
    end
  end

  # DELETE /recipe_foods/1
  def destroy
    @recipe_food.destroy
    render json: { message: 'recipe food deleted!' }, status: :no_content
  end

  private

  # Only allow a list of trusted parameters through.
  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end
end
