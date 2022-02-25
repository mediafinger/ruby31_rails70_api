# Define custom errors by inheriting from the generic Custom error:
#
# class SpecificError < Errors::Custom
#   def initialize(parameter)
#     super("Error message with #{parameter}", code: :error_code, status: 444)
#   end
# end
#
module Errors
  class Custom < StandardError
    attr_reader :backtrace, :code, :id, :message, :status

    def initialize(message = nil, status: nil, code: nil, id: nil, backtrace: nil)
      @message = message || "Sorry, something went wrong."
      @status = status || 500
      @code = code || :internal_server_error
      @id = id || SecureRandom.uuid
      @backtrace = backtrace || []
    end

    def to_s
      "#{code} #{message}"
    end
  end
end
