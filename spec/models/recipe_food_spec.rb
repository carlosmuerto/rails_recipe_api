require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
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

    @recipe = Recipe.new(
      name: 'test_recipe',
      preparation_time: 10.minutes.to_i,
      cooking_time: 20.minutes.to_i,
      description: 'test Description',
      public: true,
      author: @user
    )

    @recipe_food = RecipeFood.new(
      food: @food,
      recipe: @recipe,
      quantity: 1
    )
  end

  describe 'associations' do
    it 'should belongs_to food' do
      assc = described_class.reflect_on_association(:food)
      expect(assc.macro).to eq :belongs_to
    end

    it 'should belongs_to recipe' do
      assc = described_class.reflect_on_association(:recipe)
      expect(assc.macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'is not valid without a quantity' do
      @recipe_food.quantity = nil
      expect(@recipe_food).to_not be_valid
    end
    it 'is not valid with 0 quantity' do
      @recipe_food.quantity = 0
      expect(@recipe_food).to_not be_valid
    end
    it 'is not valid with negative quantity' do
      @recipe_food.quantity = -1
      expect(@recipe_food).to_not be_valid
    end
  end
end
