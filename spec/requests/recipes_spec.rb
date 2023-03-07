require 'swagger_helper'

RSpec.describe 'Recipe', type: :request do
  let!(:test_person) do
    User.create(
      name: 'rspec',
      email: 'rspec@rspec.com',
      password: '123rspec123'
    )
  end

  let!(:valid_food) do
    Food.create(
      name: 'Test Food',
      unit: 'Kg',
      price_per_unit: 0.5
    )
  end

  let!(:valid_recipe) do
    @recipe = Recipe.create(
      name: 'test_recipe',
      preparation_time: 10.minutes.to_i,
      cooking_time: 20.minutes.to_i,
      description: 'test Description',
      public: true,
      author: valid_food,
      recipe_food: [
        RecipeFood.new(
          food: @food,
          quantity: 1
        )
      ]
    )
  end

  
end
