# frozen_string_literal: true

module Errors
  class ContractValidation < Custom
    attr_reader :validation_result

    def initialize(validation_result)
      @validation_result = validation_result
      super(validation_result, code: :validation_error, status: 400)
    end
  end
end
