class ClientsController < ApplicationController
  def create
    client = Client.new(create_params)

    if client.save
      render status: :created, json: client.attributes.slice("name", "email", "id")
    else
      render status: :unprocessable_entity, json: client.errors
    end
  end

  def show
    client = Client.find_by!(show_params)

    render status: :ok, json: client.attributes.slice("name", "email", "id")
  end

  private

  def create_params
    validate_params!(ClientCreateContract.new, params)
  end

  def show_params
    validate_params!(IdContract.new, params)
  end
end
