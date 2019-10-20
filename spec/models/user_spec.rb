require 'spec_helper'

SHORT_BIO_VALID_LENGTH = 50

describe User do
  subject(:user) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:crypted_password) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:job_offers) }
    it { is_expected.to respond_to(:short_bio) }
    it { is_expected.to respond_to(:login_failed_attemps) }
    it { is_expected.to respond_to(:last_lock_date) }
  end

  describe 'valid?' do
    it 'should be false when name is blank' do
      user = described_class.new(email: 'john.doe@someplace.com',
                                 crypted_password: 'a_secure_passWord!',
                                 short_bio: 'A' * SHORT_BIO_VALID_LENGTH)
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:name)
    end

    it 'should be false when email is not valid' do
      user = described_class.new(name: 'John Doe', email: 'john',
                                 crypted_password: 'a_secure_passWord!',
                                 short_bio: 'A' * SHORT_BIO_VALID_LENGTH)
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:email)
    end

    it 'should be false when password is blank' do
      user = described_class.new(name: 'John Doe', email: 'john',
                                 short_bio: 'A' * SHORT_BIO_VALID_LENGTH)
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:crypted_password)
    end

    it 'should be true when all field are valid' do
      user = described_class.new(name: 'John Doe', email: 'john@doe.com',
                                 crypted_password: 'a_secure_passWord!',
                                 short_bio: 'A' * SHORT_BIO_VALID_LENGTH)
      expect(user.valid?).to eq true
    end

    it 'should be false when short bio is not provided' do
      user = described_class.new(name: 'John Doe', email: 'john@doe.com',
                                 crypted_password: 'a_secure_passWord!')
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:short_bio)
    end

    it 'should be false when short bio length is lower than 50 characters' do
      user = described_class.new(name: 'John Doe', email: 'john@doe.com',
                                 crypted_password: 'a_secure_passWord!',
                                 short_bio: 'BIO')
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:short_bio)
    end

    it 'should be false when short bio length is longer than 500 characters' do
      user = described_class.new(name: 'John Doe', email: 'john@doe.com',
                                 crypted_password: 'a_secure_passWord!',
                                 short_bio: 'A' * 501)
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:short_bio)
    end
  end

  describe 'has password?' do
    let(:password) { 'password' }
    let(:user) do
      described_class.new(password: password,
                          email: 'john.doe@someplace.com',
                          name: 'john doe',
                          short_bio: 'A' * SHORT_BIO_VALID_LENGTH)
    end

    it 'should return false when password do not match' do
      expect(user).not_to have_password('invalid')
    end

    it 'should return true when password do  match' do
      expect(user).to have_password(password)
    end
  end

  describe 'validate_password' do
    it 'should return false when password and password_validation do not match' do
      expect(user.validate_password('Passw0rd!', 'Passw0rd!!')).to eq false
      expect(user.errors).to have_key(:password)
    end

    it 'should return true when strong password and password confirmation match' do
      expect(user.validate_password('Passw0rd!', 'Passw0rd!')).to eq true
      expect(user.errors).not_to have_key(:password)
    end

    it 'should return true when password and password match but are not strong enought' do
      expect(user.validate_password('password', 'password')).to eq false
      expect(user.errors).to have_key(:password)
    end
  end

  describe 'locked?' do
    it 'should return true if last_lock_date is less than 24h' do
      user.last_lock_date = DateTime.now
      expect(user.locked?).to eq true
    end

    it 'should return false if last_lock_date is more than 24h' do
      user.last_lock_date = DateTime.now - 2
      expect(user.locked?).to eq false
    end
  end
end
