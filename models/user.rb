require_relative 'secure_password'

class User
  include ActiveModel::Validations

  attr_accessor :id, :name, :email, :crypted_password, :job_offers, :updated_on, :created_on,
                :short_bio

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  MIN_LENGTH_VALID_BIO = 50
  MAX_LENGTH_VALID_BIO = 500

  validates :name, :crypted_password, :email,
            presence: { message: 'All fields are mandatory' }
  validates :email, format: { with: VALID_EMAIL_REGEX, message: 'Invalid email' }
  validates :short_bio, length: {
    minimum: MIN_LENGTH_VALID_BIO,
    maximum: MAX_LENGTH_VALID_BIO,
    message: format('Short bio is mandatory and must have between %d and %d characters',
                    MIN_LENGTH_VALID_BIO, MAX_LENGTH_VALID_BIO)
  }

  def initialize(data = {})
    @id = data[:id]
    @name = data[:name]
    @email = data[:email]
    @crypted_password = if data[:password].nil?
                          data[:crypted_password]
                        else
                          Crypto.encrypt(data[:password])
                        end
    @job_offers = data[:job_offers]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @short_bio = data[:short_bio]
  end

  def has_password?(password)
    Crypto.decrypt(crypted_password) == password
  end

  def validate_password(_password, _password_confirm)
    errors.add(:password, 'Passwords do not match')
    false
  end
end
