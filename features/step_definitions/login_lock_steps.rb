Given('User is registered with email {string} and password {string}') do |email, password|
  @user = User.new(name: 'UserName', email: email, short_bio: 'A' * 50, password: password)
  UserRepository.new.save @user
end

When('I try to access with email {string} and wrong password {int} times') do |email, times|
  times.times do
    visit '/login'
    fill_in('user[email]', with: email)
    fill_in('user[password]', with: 'PassW0rd!1231457')
    click_button('Login')
  end
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
