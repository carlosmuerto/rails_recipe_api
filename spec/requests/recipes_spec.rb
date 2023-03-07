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

  pending "add some examples to (or delete) #{__FILE__}"
end
