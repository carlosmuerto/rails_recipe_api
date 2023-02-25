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
  let(:valid_attributes) do
    Food.create(
      name: 'Test Food',
      unit: 'Kg',
      price_per_unit: 0.5
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
  end
end

# rubocop:enable Metrics/BlockLength