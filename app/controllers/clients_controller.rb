class ClientsController < ApplicationController
  def create
    client = Client.new(create_params)
    client.preferences = { unconfirmed_email: client.email }

    if client.save
      render status: :created, jsonapi: client
    else
      render status: :unprocessable_entity, jsonapi_errors: client.errors
    end
  end

  def show
    client = Client.find_by!(show_params)

    render status: :ok, jsonapi: client
  end

  private

  def create_params
    validate_params_for!(ClientCreateContract.new, :client)
  end

  def show_params
    validate_params!(IdContract.new, params)
  end
end
