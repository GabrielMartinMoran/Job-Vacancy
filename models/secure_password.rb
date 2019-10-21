class SecurePassword
  VALID_PASSWORD_REGEX = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[¿?¡!#$%+\-_]).{8,20}$/

  def self.is_secure(password)
    !VALID_PASSWORD_REGEX.match(password).nil?
  end
end
