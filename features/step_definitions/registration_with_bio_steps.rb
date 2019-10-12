Given('User acceses to the register page') do
  visit '/register'
end

When('User fills email with {string} and password, password confirmation and name with valid values') do |email|
  fill_in('user[name]', with: 'UserName')
  fill_in('user[email]', with: email)
  fill_in('user[password]', with: 'PassW0rd!123')
  fill_in('user[password_confirmation]', with: 'PassW0rd!123')
end

When('User fills short bio with a text of {int} characters length') do |bio_length|
  short_bio = 'A' * bio_length
  fill_in('user[short_bio]', with: short_bio)
end

When('User tries to register') do
  click_button('Create')
end

Then('User should be able to login with email {string}') do |email|
  visit '/login'
  fill_in('user[email]', with: email)
  fill_in('user[password]', with: 'PassW0rd!123')
  click_button('Login')
  assert_current_path('/')
  page.should have_content(email)
end

Then('User should see a message indicating error on short bio') do
  pending # Write code here that turns the phrase above into concrete actions
end
