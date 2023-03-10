require 'rails_helper'

RSpec.describe UserFood, type: :model do
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

    @user_food = UserFood.new(
      user: @user,
      food: @food,
      quantity: 5.1
    )
  end

  describe 'associations' do
    it 'should belongs_to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it 'should belongs_to food' do
      assc = described_class.reflect_on_association(:food)
      expect(assc.macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'is not valid without a quantity' do
      @user_food.quantity = nil
      expect(@user_food).to_not be_valid
    end

    it 'is not valid with negative quantity' do
      @user_food.quantity = -10.1
      expect(@user_food).to_not be_valid
    end

    it 'is valid with 0 quantity' do
      @user_food.quantity = 0
      expect(@user_food).to be_valid
    end
  end
end
