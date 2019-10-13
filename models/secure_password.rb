class SecurePassword
  def self.is_secure(password)
    !/\d/.match(password).nil? &&
      !/[a-z]/.match(password).nil?
  end
end
