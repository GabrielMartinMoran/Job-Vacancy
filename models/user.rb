require_relative 'secure_password'
require_relative 'taggable'

class User
  include ActiveModel::Validations
  include Taggable

  attr_accessor :id, :name, :email, :crypted_password, :job_offers, :updated_on, :created_on,
                :short_bio, :login_failed_attempts, :last_lock_date, :prefered_tags

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  MIN_LENGTH_VALID_BIO = 50
  MAX_LENGTH_VALID_BIO = 500
  MIN_LOCKED_HOURS = 24
  MAX_LOGIN_FAILED_ATTEMPS = 3
  MAX_PREFERED_TAGS = 10

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
    @crypted_password = obtain_crypted_password(data[:password], data[:crypted_password])
    @job_offers = data[:job_offers]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @short_bio = data[:short_bio]
    @prefered_tags = parse_tags(data[:prefered_tags], MAX_PREFERED_TAGS)
    load_lock_data(data)
  end

  def has_password?(password)
    Crypto.decrypt(crypted_password) == password
  end

  def validate_password(password, password_confirm)
    validations_map = [
      { validation: password == password_confirm, error_message: 'Passwords do not match' },
      { validation: SecurePassword.is_secure(password), error_message: 'Password must have
        between 8 and 20 characters and at least a number, a lowercase letter, an uppercase letter
        and a symbol like ¿ ? ¡ ! # $ % + \\ - _ ' }
    ]
    validations_map.each do |x|
      unless x[:validation]
        errors.add(:password, x[:error_message])
        return false
      end
    end

    true
  end

  def locked?
    return false if @last_lock_date.nil?

    (Time.now - @last_lock_date) < (MIN_LOCKED_HOURS * 3600)
  end

  def add_login_failed_attempt
    @login_failed_attempts += 1

    return unless @login_failed_attempts >= MAX_LOGIN_FAILED_ATTEMPS

    @login_failed_attempts = 0
    @last_lock_date = Time.now
  end

  def password=(password)
    @crypted_password = Crypto.encrypt(password)
  end

  def valid?
    unless @has_valid_tags
      errors.add(:prefered_tags, 'Too much prefered tags')
      return false
    end

    super
  end

  private

  def obtain_crypted_password(password, crypted_password)
    if password.nil?
      crypted_password
    else
      Crypto.encrypt(password)
    end
  end

  def load_lock_data(data)
    @login_failed_attempts = data[:login_failed_attempts] || 0
    @last_lock_date = data[:last_lock_date]
  end
end
