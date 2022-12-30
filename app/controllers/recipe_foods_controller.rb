class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe_food, only: %i[show destroy]

  # GET /recipe_foods
  def index
    @recipe_foods = RecipeFood.all

    render json: @recipe_foods
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
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end
end
