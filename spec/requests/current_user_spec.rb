require 'swagger_helper'

RSpec.describe 'current_user', type: :request do
  let!(:test_person) do
    User.create(
      name: 'rspec',
      email: 'rspec@rspec.com',
      password: '123rspec123'
    )
  end

  path '/current_user' do
    get 'Get current user' do
      consumes 'application/json'
      produces 'application/json'

      security [{ bearer_auth: [] }]

      response 401, 'Unauthorized' do
        let(:Authorization) { '' }
        run_test!
      end

      response 200, 'OK' do
        schema '$ref' => '#/components/schemas/User'

        let(:Authorization) do
          Devise::JWT::TestHelpers.auth_headers({}, test_person)['Authorization']
        end

        run_test!
      end
    end
  end
end
