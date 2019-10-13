require 'rspec'
require_relative '../../models/secure_password'

describe SecurePassword do
  context 'when is_secure' do
    it 'should return true if password is Passw0rd!' do
      expect(described_class.is_secure('Passw0rd!')).to eq true
    end
  end
end
