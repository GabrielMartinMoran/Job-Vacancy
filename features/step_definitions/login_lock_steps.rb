Given('User is registered with email {string} and password {string}') do |email, password|
  @user = User.new(name: 'UserName', email: email, short_bio: 'A' * 50, password: password)
  UserRepository.new.save @user
end

When('I try to acces with email {string} and wrong password {int} times') do |_string, _int|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('An error indicating that the account is locked should be displayed if user tries to log in') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('User with email {string} is locked') do |_string|
  pending # Write code here that turns the phrase above into concrete actions
end

When('{int} hours passed') do |_int|
  pending # Write code here that turns the phrase above into concrete actions
end
