require 'integration_spec_helper'

describe UserRepository do
  let(:repository) { described_class.new }

  describe 'save' do
    let(:registered_user) do
      user = User.new(name: 'user', email: 'user_repository@test.com',
                      crypted_password: 'secure_pwd', short_bio: 'A' * 50)
      repository.save(user)
      user
    end

    it 'should raise exception if creating new user with used email' do
      new_user = User.new(name: 'user_02', email: registered_user.email,
                          crypted_password: 'secure_pwd', short_bio: 'A' * 50)
      expect { repository.save(new_user) }
        .to raise_exception(StandardError, 'User email must be unique')
    end
  end
end
