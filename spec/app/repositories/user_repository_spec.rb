require 'integration_spec_helper'

describe UserRepository do
  let(:repository) { described_class.new }

  let!(:registered_user) do
    user = User.new(name: 'user', email: 'user_repository@test.com',
                    crypted_password: 'secure_pwd', short_bio: 'A' * 50,
                    prefered_tags: 'prefered_tag1,prefered_tag2')
    repository.save(user)
    user
  end

  describe 'save' do
    it 'should raise exception if creating new user with used email' do
      new_user = User.new(name: 'user_02', email: registered_user.email,
                          crypted_password: 'secure_pwd', short_bio: 'A' * 50)
      expect { repository.save(new_user) }
        .to raise_exception(StandardError, 'User email must be unique')
    end
  end

  describe 'find' do
    it 'should load prefered_tags' do
      obtained = repository.find(registered_user.id)
      expect(obtained.prefered_tags).to eq(registered_user.prefered_tags)
    end
  end

  describe 'find_by_matching_tags' do
    let!(:user1) do
      user1 = User.new(name: 'user1', email: 'user_repository1@test.com',
                       crypted_password: 'secure_pwd', short_bio: 'A' * 50,
                       prefered_tags: 'prefered_tag3,prefered_tag4')
      repository.save(user1)
      user1
    end

    let!(:user2) do
      user2 = User.new(name: 'user2', email: 'user_repository2@test.com',
                       crypted_password: 'secure_pwd', short_bio: 'A' * 50,
                       prefered_tags: 'prefered_tag4,prefered_tag5')
      repository.save(user2)
      user2
    end

    it 'should return users with matching prefered_tags' do
      prefered_tags = %w[prefered_tag4 prefered_tag6]
      result = repository.find_by_matching_tags(prefered_tags)
      expect(result.map(&:id)).to include(user1.id, user2.id)
      expect(result.size).to eq(2)
    end
  end
end
