# rubocop:disable Metrics/BlockLength
require 'swagger_helper'

RSpec.describe 'UserFood', type: :request do
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

  let!(:valid_user_food) do
    UserFood.create(
      user: test_person,
      food: valid_food,
      quantity: 5.1
    )
  end

  path '/user_foods' do
    get 'Get User foods List' do
      consumes 'application/json'
      produces 'application/json'

      security [{ bearer_auth: [] }]

      response 401, 'Unauthorized' do
        let(:Authorization) { '' }
        run_test!
      end

      response 200, 'OK' do
        schema type: :array, items: { '$ref' => '#/components/schemas/UserFood' }

        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
        end

        run_test!
      end
    end

    post 'Create a User food' do
      consumes 'application/json'
      produces 'application/json'

      security [{ bearer_auth: [] }]

      parameter name: :UserFood, in: :body, schema: {
        type: :object,
        properties: {
          food_id: { type: :integer, example: 2 },
          quantity: { type: :number, example: 0.01 }
        },
        required: %w[
          food_id
          quantity
        ]
      }

      response 401, 'Unauthorized' do
        let(:Authorization) { '' }

        let(:UserFood) do
          {
            food_id: valid_food.id,
            quantity: 1.1
          }
        end

        run_test!
      end

      response 422, 'Unprocessable Entity' do
        schema '$ref' => '#/components/schemas/ErrorResponses'

        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
        end

        let(:UserFood) do
          {
            food_id: valid_food.id,
            quantity: -1.1
          }
        end

        run_test!
      end

      response 201, 'Created' do
        schema '$ref' => '#/components/schemas/UserFood'

        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
        end

        let(:UserFood) do
          {
            food_id: valid_food.id,
            quantity: 1.1
          }
        end

        run_test!
      end
    end

    path '/user_foods/{id}' do
      get 'get User Food info' do
        consumes 'application/json'
        produces 'application/json'

        security [{ bearer_auth: [] }]

        parameter name: :id, in: :path, type: :integer

        response 401, 'Unauthorized' do
          let(:Authorization) { '' }

          let(:id) { valid_user_food.id }

          run_test!
        end

        response 200, 'OK' do
          schema  '$ref' => '#/components/schemas/UserFood'

          let(:id) { valid_user_food.id }
  
          let(:Authorization) do
            Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
          end
  
          run_test!
        end
      end

      delete 'delete a User food' do
        consumes 'application/json'
        produces 'application/json'

        security [{ bearer_auth: [] }]

        parameter name: :id, in: :path, type: :integer

        response 401, 'Unauthorized' do
          let(:Authorization) { '' }

          let(:id) { valid_user_food.id }

          run_test!
        end

        response 204, 'No Content' do
          let(:id) { valid_user_food.id }

          let(:Authorization) do
            Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
          end

          run_test!
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
