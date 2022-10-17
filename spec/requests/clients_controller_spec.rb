require "rails_helper"

RSpec.describe ClientsController, type: :request do
  describe "GET /clients" do
    let(:client) { Client.create!(email: "andy@example.com", name: "andy", password: "foobar1234") }

    it "returns the JSON representation of a client" do
      get client_path(client.id)

      expect(response).to have_http_status(200)
      expect(parsed_response).to eq(
        {
          "email" => "andy@example.com",
          "id"    => client.id,
          "name"  => "andy"
        }
      )
    end
  end

  describe "POST /clients" do
    let(:params) { { email: "andy@example.com", name: "andy", password: "foobar1234" } }

    it "returns the JSON representation of a newly created client" do
      post clients_path, params: params

      expect(response).to have_http_status(201)
      expect(parsed_response).to eq(
        {
          "email" => "andy@example.com",
          "id"    => Client.last.id,
          "name"  => "andy"
        }
      )
    end
  end
end