class Client < ApplicationRecord
  SEPARATOR = "::".freeze

  has_secure_password :password, validations: false

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "not valid" }
  validates :password, length: { in: 10..72 }, on: %i(create reset_password) # 72 is a has_secure_password limitation
  validates :name, length: { in: 3..255 }

  scope :with_unconfirmed_email, -> { where("preferences ? :key", key: "unconfirmed_email") }

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

  # this custom setter ensures keys once set are never removed again
  # it only allows to add key-value-pairs or change values (also to nil)
  def preferences=(hash)
    fail ActiveModel::ForbiddenAttributesError, "preferences= expects a parameter of type Hash" unless hash.is_a?(Hash)

    super(preferences.merge(hash))
  end

  def confirm_and_update_email!
    unconfirmed = preferences["unconfirmed_email"]

    raise StandardError, "No unconfirmed email found, keeping current, please restart your operation" if unconfirmed.nil?

    former_emails = preferences["former_emails"] || []
    self.preferences["former_emails"] = former_emails << email unless email == unconfirmed
    self.preferences["unconfirmed_email"] = nil
    self.email = unconfirmed
    save!
  end
end
