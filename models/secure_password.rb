class SecurePassword
  def self.is_secure(password)
    !/\d/.match(password).nil?
  end
end