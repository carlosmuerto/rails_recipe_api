# rubocop:disable Metrics/BlockLength
require 'swagger_helper'

RSpec.describe 'food', type: :request do
  let!(:test_person) do
    User.create(
      name: 'rspec',
      email: 'rspec@rspec.com',
      password: '123rspec123'
    )
  end

  let!(:test_food) do
    Food.create(
      name: 'Test Food',
      unit: 'Kg',
      price_per_unit: 0.5
    )
  end
  let(:test_UserFood) do
    UserFood.create(
      user: test_person,
      food: test_food,
      quantity: 5.1
    )
  end

  path '/foods' do
    get 'Get foods List' do
      consumes 'application/json'
      produces 'application/json'

      security [{ bearer_auth: [] }]

      response 401, 'Unauthorized' do
        let(:Authorization) { '' }
        run_test!
      end

      response 200, 'OK' do
        schema type: :array, items: { '$ref' => '#/components/schemas/Food' }

        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
        end

        run_test!
      end
    end

    post 'Create a food' do
      consumes 'application/json'
      produces 'application/json'

      security [{ bearer_auth: [] }]

      parameter name: :Food, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Tomatoes' },
          unit: { type: :string, example: 'g' },
          price_per_unit: { type: :number, example: 0.01 }
        },
        required: %w[
          name
          unit
          price_per_unit
        ]
      }

      response 401, 'Unauthorized' do
        let(:Authorization) { '' }

        let(:Food) do
          {
            food: {
              name: 'Tomatoes',
              unit: 'Kg',
              price_per_unit: 1.5
            }
          }
        end

        run_test!
      end

      response 422, 'Unprocessable Entity' do
        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
        end

        let(:Food) do
          {
            food: {
              name: 'Tomatoes',
              unit: 'Kg',
              price_per_unit: -1.5
            }
          }
        end

        run_test!
      end

      response 201, 'Created' do
        schema '$ref' => '#/components/schemas/Food'

        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
        end

        let(:Food) do
          {
            food: {
              name: 'Tomatoes',
              unit: 'Kg',
              price_per_unit: 1.5
            }
          }
        end

        run_test!
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
