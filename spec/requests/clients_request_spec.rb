require "rails_helper"

RSpec.describe ClientsController, type: :request do
  describe "GET /clients" do
    let(:client) { FactoryBot.create(:client, email: "andy@example.com", name: "andy") }

    it "returns the JSON representation of a client" do
      get client_path(client.id)

      expect(response).to have_http_status(200)
      expect(parsed_response).to eq(
        {
          "data" => {
            "attributes" => {
              "email" => "andy@example.com",
              "id" => client.id,
              "name" => "andy"
            },
            "id" => client.id,
            "type" => "client",
          },
        }
      )
    end
  end

  describe "POST /clients" do
    context "when params are valid and complete" do
      let(:body) do
        {
          data: {
            type: :client,
            attributes: params,
          },
        }
      end
      let(:params) { { email: "andy@example.com", name: "andy", password: "foobar1234" } }

      it "returns the JSON representation of a newly created client" do
        post clients_path, params: body

        expect(response).to have_http_status(201)
        expect(parsed_response).to eq(
          {
            "data" => {
              "attributes" => {
                "email" => "andy@example.com",
                "id" => Client.last.id,
                "name" => "andy"
              },
              "id" => Client.last.id,
              "type" => "client",
            },
          }
        )
      end
    end

    context "when params are incomplete or invalid", aggregate_failures: true do
      let(:body) do
        {
          data: {
            type: :client,
            attributes: params,
          },
        }
      end
      let(:params) { { email: "andy@example.com", name: "andy" } }

      it "returns an error" do
        expect(Rails.logger).to receive(:warn).with(
          /ParamsValidationError message='\[:password\] is missing' code=unprocessable_entity status=422 id=/
        )

        post clients_path, params: body

        expect(response).to have_http_status(422)
        expect(parsed_response["error"]).to include(
          {
            "code" => "unprocessable_entity",
            "id" => matches_uuid,
            "message" => "ParamsValidationError: [:password] is missing",
          }
        )
      end
    end

    context "when JSON resource :type is missing or wrong", aggregate_failures: true do
      let(:body) do
        {
          data: {
            attributes: params,
          },
        }
      end
      let(:params) { { hello: :wat } } # does not matter, it fails sooner

      it "returns an error" do
        expect(Rails.logger).to receive(:warn).with(
          /ParamsTypeError message=':type contained '' expected 'client'' code=bad_request status=400 id=/
        )

        post clients_path, params: body

        expect(response).to have_http_status(400)
        expect(parsed_response["error"]).to include(
          {
            "code" => "bad_request",
            "id" => matches_uuid,
            "message" => "ParamsTypeError: :type contained '' expected 'client'",
          }
        )
      end
    end
  end
end
