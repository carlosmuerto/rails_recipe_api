# rubocop:disable Metrics/BlockLength

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'RECIPE API'
      },
      components: {
        securitySchemes: {
          bearer_auth: {
            type: :http,
            scheme: :bearer
          }
        },
        schemas: {
          Food: {
            type: :object,
            properties: {
              id: { type: :integer, example: 2 },
              name: { type: :string, example: 'Tomatoes' },
              unit: { type: :string, example: 'g' },
              price_per_unit: { type: :string, example: '0.01' }
            }
          },
          Recipe: {
            type: :object,
            properties: {
              id: { type: :integer, example: 2 },
              name: { type: :string, example: 'Hoppscotchs' },
              description: { type: :string, example: "really tasty food" },
              public: { type: :boolean, example: false },
              preparation_time: { type: :integer, example: 360 },
              cooking_time: { type: :integer, example: 360 },
              author: { '$ref' => '#/components/schemas/User' },
              foods: {
                type: :array,
                items: { '$ref' => '#/components/schemas/UserFood' },
              }
            }
          },
          UserFood: {
            type: :object,
            properties: {
              food: { '$ref' => '#/components/schemas/Food' },
              quantity: { type: :string, example: '0.01' }
            }
          },
          User: {
            type: :object,
            properties: {
              id: { type: :integer, example: 2 },
              name: { type: :string, example: 'Scott Wells' },
              email: { type: :string, example: 'scott_wells@test.com' },
              created_at: { type: :string, example: '2023-02-22T02:16:55.863Z' }
            }
          },
          status: {
            type: :object,
            properties: {
              code: { type: :integer, example: 200 },
              message: { type: :string, example: 'Signed up sucessfully.' }
            }
          },
          ErrorResponses: {
            type: :object,
            properties: {
              name: {
                type: :array,
                items: {
                  type: :string,
                  example: [
                    "can't be blank"
                  ]
                }
              },
              unit: {
                type: :array,
                items: {
                  type: :string,
                  example: [
                    "can't be blank",
                    'is not included in the list'
                  ]
                }
              },
              price_per_unit: {
                type: :array,
                items: {
                  type: :string,
                  example: [
                    "can't be blank",
                    'is not a number'
                  ]
                }
              }
            }
          }
        }
      }
    }
  }

  # {
  #   "name": [
  #     "can't be blank"
  #   ],
  #   "unit": [
  #     "can't be blank",
  #     "is not included in the list"
  #   ],
  #   "price_per_unit": [
  #     "can't be blank",
  #     "is not a number"
  #   ]
  # }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end

# rubocop:enable Metrics/BlockLength
