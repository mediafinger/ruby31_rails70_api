class Client < ApplicationRecord
  SEPARATOR = "::".freeze

  has_secure_password :password, validations: false

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "not valid" }
  validates :password, length: { in: 10..72 }, on: %i(create reset_password) # 72 is a has_secure_password limitation
  validates :name, length: { in: 3..255 }

  class << self
    def authenticate_temp_auth_token!(base64)
      expires_at, token = Base64.urlsafe_decode64(base64.to_s).split(SEPARATOR)
      raise(StandardError, "Token expired, please restart your operation") if expires_at.nil? || token.nil?
      raise(StandardError, "Token expired, please restart your operation") if Time.zone.now > Time.parse(expires_at)

      client = Client.find_by(temp_auth_token: base64)
      raise(StandardError, "Token expired, please restart your operation") unless client

      # returning the client means authorizing the operation, e.g. email confirmation or password reset
      client.update!(temp_auth_token: nil) # additionally a job to delete all outdated tokens would make sense
      client
    end
  end

  def generate_temp_auth_token!
    token = Base64.urlsafe_encode64("#{10.minutes.from_now}#{SEPARATOR}#{SecureRandom.uuid}")
    self.update!(temp_auth_token: token)
    token
  end
end
