module ContractValidation
  def self.validate!(contract, params)
    result = contract.call(**params)

    raise ::Errors::ContractValidation, result if result.failure?

    result.to_h
  end
end
