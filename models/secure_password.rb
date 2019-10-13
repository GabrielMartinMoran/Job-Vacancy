class SecurePassword
  VALID_SYMBOLS_REGEX = /[¿?¡!#$%+\-_]/

  def self.is_secure(password)
    !/\d/.match(password).nil? &&
      !/[a-z]/.match(password).nil? &&
      !/[A-Z]/.match(password).nil? &&
      !VALID_SYMBOLS_REGEX.match(password).nil? &&
      password.length.between?(8, 20)
  end
end
