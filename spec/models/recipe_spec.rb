require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:each) do
    @user = User.create(
      name: 'rspec',
      email: 'rspec@rspec.com',
      password: '123rspec123'
    )

    @food = Food.create(
      name: 'Test Food',
      unit: 'Kg',
      price_per_unit: 0.5
    )

    @recipe_food = [
      RecipeFood.new(
        food: @food,
        quantity: 1
      )
    ]

    @recipe = Recipe.new(
      name: 'test_recipe',
      preparation_time: 10.minutes.to_i,
      cooking_time: 20.minutes.to_i,
      description: 'test Description',
      public: true,
      author: @user,
      recipe_food: @recipe_food
    )
  end

  describe 'associations' do
    it 'should belongs_to author user' do
      assc = described_class.reflect_on_association(:author)
      expect(assc.macro).to eq :belongs_to
    end

    it 'should has_many foods' do
      assc = described_class.reflect_on_association(:foods)
      expect(assc.macro).to eq :has_many
    end
  end

  describe 'validations' do
    it 'is not valid without a name' do
      @recipe.name = nil
      expect(@recipe).to_not be_valid
    end

    it 'is not valid without a preparation_time' do
      @recipe.preparation_time = nil
      expect(@recipe).to_not be_valid
    end

    it 'is not valid without a preparation_time of 0' do
      @recipe.preparation_time = 0
      expect(@recipe).to_not be_valid
    end

    it 'is not valid without a negative preparation_time' do
      @recipe.preparation_time = -1
      expect(@recipe).to_not be_valid
    end

    it 'is not valid without a cooking_time' do
      @recipe.cooking_time = nil
      expect(@recipe).to_not be_valid
    end

    it 'is not valid without a negative cooking_time' do
      @recipe.cooking_time = -1
      expect(@recipe).to_not be_valid
    end

    it 'is not valid without a description' do
      @recipe.description = nil
      expect(@recipe).to_not be_valid
    end

    it 'is not valid without a public' do
      @recipe.public = nil
      expect(@recipe).to_not be_valid
    end

    it 'is not valid with 0 a recipe_food' do
      @recipe.recipe_food = []
      expect(@recipe).to_not be_valid
    end
  end
end
