require "swagger_helper"

RSpec.describe "clients", type: :request do
  after do |example|
    example.metadata[:response][:content] = {
      "application/json" => {
        example: JSON.parse(response.body, symbolize_names: true)
      }
    }
  end

  path "/clients" do
    post("create client") do
      description "Create a client"
      consumes "application/json"
      produces "application/json"

      parameter name: :client, in: :body, schema: {
        type: :object,
        required: %w(email name password),
        properties: {
          email: {
            type: :email,
            description: "email",
            example: "andy@example.com",
          },
          name: {
            type: :string,
            description: "name",
            example: "Andy",
          },
          password: {
            type: :string,
            description: "password",
            example: "foobar1234",
          },
        },
      }

      response(201, "created") do
        # give example, can be used in the spec
        # request_example value: { some_field: 'Foo' }, name: 'request_example_1', summary: 'A request example'

        let(:client) do
          {
            data: {
              type: :client,
              attributes: { email: "andy@example.com", name: "andy", password: "foobar1234" },
            }
          }
        end

        run_test!
      end

      response(400, "bad_request") do
        let(:client) { { } }

        run_test!
      end
    end
  end

  path "/clients/{id}" do
    parameter name: "id", in: :path, type: :uuid, description: "id"

    get("show client") do
      description "Read a client"
      consumes "application/json"
      produces "application/json"

      response(200, "successful") do
        let(:id) { FactoryBot.create(:client).id }

        run_test!
      end

      response(404, "not_found") do
        let(:id) { SecureRandom.uuid }

        run_test!
      end

      response(422, "unprocessable_entity") do
        let(:id) { "123" }

        run_test!
      end
    end
  end
end
