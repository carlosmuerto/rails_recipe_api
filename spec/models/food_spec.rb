require 'rails_helper'

RSpec.describe Food, type: :model do

  before(:each) do
    @food = Food.new(
      name: 'Test Food',
      unit: 'Kg',
      price_per_unit: 0.5
    )
  end

  describe 'validations' do
    it 'is valid if all field is correct' do
      expect(@food).to be_valid
    end
    it 'is not valid without a name' do
      @food.name = nil
      expect(@food).to_not be_valid
    end

    it 'is not valid without a unit' do
      @food.unit = nil
      expect(@food).to_not be_valid
    end

    it 'is not valid with a not valid unit' do
      @food.unit = 'pound'
      expect(@food).to_not be_valid
    end

    it 'is not valid price_per_unit is negative' do
      @food.price_per_unit = -1.1
      expect(@food).to_not be_valid
    end
  end
end
