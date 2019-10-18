When('User {string} tries to register') do |email|
  fill_in('user[name]', with: 'UserName')
  fill_in('user[email]', with: email)
  fill_in('user[password]', with: 'PassW0rd!123')
  fill_in('user[password_confirmation]', with: 'PassW0rd!123')
  fill_in('user[short_bio]', with: 'A' * 50)
  click_button('Create')
end

Given('User {string} is already registered') do |email|
  @user = User.new
  @user.name = 'UserName'
  @user.email = email
  @user.crypted_password = 'PassW0rd!123'
  @user.short_bio = 'A' * 50

  UserRepository.new.save @user
end

Then('User should be registered succesfully') do
  assert_current_path('/')
  page.should have_content('User created')
end

Then('User should see a message indicating error user is already registered') do
  page.should have_content('An user with same email is already registered')
end
