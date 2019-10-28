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

Then('An error indicating that the account is locked should be displayed if user tries to log in') do
  visit '/login'
  fill_in('user[email]', with: @user.email)
  fill_in('user[password]', with: @password)
  click_button('Login')
  page.should have_content('This account is locked')
end

Given('User with email {string} is locked') do |email|
  @user = User.new(name: 'UserName', email: email, short_bio: 'A' * 50, password: @password,
                   last_lock_date: Time.now)
  UserRepository.new.save @user
  @user.locked?.should be true
end

When('{int} hours passed') do |hours|
  Timecop.travel(Time.now + hours * 3600)
end
