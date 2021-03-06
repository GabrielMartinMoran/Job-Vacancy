Given('User is registered with email {string} and password {string}') do |email, password|
  @password = password
  @user = User.new(name: 'UserName', email: email, short_bio: 'A' * 50, password: password)
  UserRepository.new.save @user
end

When('I try to access with email {string} and wrong password {int} times') do |email, times|
  visit '/login'
  times.times do
    fill_in('user[email]', with: email)
    fill_in('user[password]', with: 'PassW0rd!1231457')
    click_button('Login')
  end
end

When('I try to access with email {string}') do |email|
  visit '/login'
  fill_in('user[email]', with: email)
  fill_in('user[password]', with: @password)
  click_button('Login')
end

Then('An error indicating that the account is locked should be displayed if user tries to log in') do
  visit '/login'
  fill_in('user[email]', with: @user.email)
  fill_in('user[password]', with: @password)
  click_button('Login')
  page.should have_content('This account is locked')
end

Given('User with email {string} was locked yesterday') do |email|
  DAY_IN_SECONDS = 60 * 60 * 24
  @user = User.new(name: 'UserName', email: email, short_bio: 'A' * 50, password: @password,
                   last_lock_date: Time.now - DAY_IN_SECONDS)
  @email = email
  UserRepository.new.save @user
end
