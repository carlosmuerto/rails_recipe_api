class RecipesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /recipes
  def index
    # @recipes = Food.all

    render json: @recipes.map { |item|
      RecipeSerializer.new(item).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  # GET /recipes/1
  def show
    render json: RecipeSerializer.new(@recipe).serializable_hash[:data][:attributes], status: :ok
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.author = current_user

    @recipe.recipe_food =  params.require(:recipe)
      .except(:name, :preparation_time, :cooking_time, :description, :public)
      .permit(foods: [:food_id, :quantity])[:foods].map do |recipe_food|
      RecipeFood.new(
        food: Food.find(recipe_food.require(:food_id)),
        quantity: recipe_food.require(:quantity)
      )
    end

    if @recipe.save
      render json: RecipeSerializer.new(@recipe).serializable_hash[:data][:attributes], status: :created
    else
      render json: {
        item: RecipeSerializer.new(@recipe).serializable_hash[:data][:attributes],
        errors: @recipe.errors
      },
      status: :unprocessable_entity
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
    render json: { message: 'recipe deleted!' }, status: :no_content
  end

  private

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).except(:foods).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
