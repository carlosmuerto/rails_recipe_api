# rubocop:disable Metrics/BlockLength
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
      author: test_person,
      recipe_food: [
        RecipeFood.new(
          food: valid_food,
          quantity: 1
        )
      ]
    )
  end

  path '/recipes' do
    get 'Get User current Recipes List' do
      consumes 'application/json'
      produces 'application/json'

      security [{ bearer_auth: [] }]

      response 401, 'Unauthorized' do
        let(:Authorization) { '' }
        run_test!
      end

      response 200, 'OK' do
        schema type: :array, items: { '$ref' => '#/components/schemas/Recipe' }

        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
        end

        run_test!
      end
    end

    post 'Create a Recipe' do
      consumes 'application/json'
      produces 'application/json'

      security [{ bearer_auth: [] }]

      parameter name: :recipe, in: :body, schema: {
        type: :object,
        properties: {
          recipe: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Hoppscotchs' },
              description: { type: :string, example: 'really tasty food' },
              public: { type: :boolean, example: false },
              preparation_time: { type: :integer, example: 360 },
              cooking_time: { type: :integer, example: 360 },
              foods: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    food_id: { type: :integer, example: 1 },
                    quantity: { type: :numericality, example: 1.1 }
                  },
                  required: %w[
                    food_id
                    quantity
                  ]
                }
              }
            },
            required: %w[
              name
              description
              preparation_time
              cooking_time
              public
            ]
          }
        },
        required: %w[
          recipe
        ]
      }

      response 401, 'Unauthorized' do
        let(:Authorization) { '' }

        let(:recipe) do
          {
            recipe: {
              name: 'Hoppscotchs',
              description: 'really tasty food',
              preparation_time: 360,
              cooking_time: 360,
              public: true,
              foods: [
                {
                  food_id: valid_food.id,
                  quantity: 1.1
                }
              ]
            }
          }
        end

        run_test!
      end

      response 422, 'Unprocessable Entity' do
        schema '$ref' => '#/components/schemas/ErrorResponses'

        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
        end

        let(:recipe) do
          {
            recipe: {
              name: 'Hoppscotchs',
              description: 'really tasty food',
              preparation_time: 360,
              cooking_time: 360,
              public: true,
              foods: []
            }
          }
        end

        run_test!
      end

      response 201, 'Created' do
        schema '$ref' => '#/components/schemas/UserFood'

        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
        end

        let(:recipe) do
          {
            recipe: {
              name: 'Hoppscotchs',
              description: 'really tasty food',
              preparation_time: 360,
              cooking_time: 360,
              public: true,
              foods: [
                {
                  food_id: valid_food.id,
                  quantity: 1.1
                }
              ]
            }
          }
        end

        run_test!
      end
    end
  end

  path '/recipes/publics' do
    get 'Get publics Recipes List' do
      consumes 'application/json'
      produces 'application/json'

      security [{ bearer_auth: [] }]

      response 401, 'Unauthorized' do
        let(:Authorization) { '' }
        run_test!
      end

      response 200, 'OK' do
        schema type: :array, items: { '$ref' => '#/components/schemas/Recipe' }

        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
        end

        run_test!
      end
    end
  end

  path '/recipes/{id}' do
    get 'get User Food info' do
      consumes 'application/json'
      produces 'application/json'

      security [{ bearer_auth: [] }]

      parameter name: :id, in: :path, type: :integer

      response 401, 'Unauthorized' do
        let(:Authorization) { '' }

        let(:id) { valid_recipe.id }

        run_test!
      end

      response 200, 'OK' do
        schema '$ref' => '#/components/schemas/Recipe'

        let(:id) { valid_recipe.id }

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

        let(:id) { valid_recipe.id }

        run_test!
      end

      response 204, 'No Content' do
        let(:id) { valid_recipe.id }

        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
        end

        run_test!
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
