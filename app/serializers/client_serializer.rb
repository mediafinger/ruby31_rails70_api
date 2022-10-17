class ClientSerializer < ApplicationSerializer
  set_type :client # optional, sets the type: attribute in the JSONAPI response

  attributes *%i(
    email
    id
    name
  )
end
