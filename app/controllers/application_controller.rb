class ApplicationController < ActionController::API
  # dry-validates the dry-contract against the given params
  # which can be either a hash or an ActionController::Parameters object
  #
  def validate_params!(contract, parameters)
    p = parameters.is_a?(ActionController::Parameters) ? parameters.to_unsafe_h : parameters

    ContractValidation.validate!(contract, p)
  end

  # dry-validates the dry-contract implictly against the content of the params' :data key
  # which are expected to adhere to the JSON:API standard https://jsonapi.org/format/#crud-creating
  # ensure the :type is present and matches the given type (throws 400 if not)
  #
  def validate_params_for!(contract, type)
    raise ParamsTypeError.new(key: :type, got: data_params[:type], expected: type) if data_params[:type].to_s != type.to_s

    ContractValidation.validate!(contract, data_params[:attributes])
  end

  # we let Rails / ActionController::StrongParameters ensure that
  # the json request body includes a :data key (and that it is not empty)
  #
  def data_params
    params.require(:data).to_unsafe_h # contains :type and attributes: {...}
  end

  # throwing the error here, after catching it in our routes,
  # means our normal error handler process will be used
  # to log the error and display a message to the user
  def error_404
    raise ActionController::RoutingError.new("Path #{request.path} could not be found")
  end
end
