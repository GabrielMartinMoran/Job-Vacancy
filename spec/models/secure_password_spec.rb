require 'rspec'
require_relative '../../models/secure_password'

describe SecurePassword do
  context 'when is_secure' do
    it 'should return true if password is Passw0rd!' do
      expect(described_class.is_secure('Passw0rd!')).to eq true
    end

    it 'should return false if password not has a number' do
      expect(described_class.is_secure('Password!')).to eq false
    end

    it 'should return false if password not has a lowercase letter' do
      expect(described_class.is_secure('PASSW0RD!')).to eq false
    end
  end
end
