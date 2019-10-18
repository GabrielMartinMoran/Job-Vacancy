When('User {string} tries to register') do |email|
  fill_in('user[name]', with: 'UserName')
  fill_in('user[email]', with: email)
  fill_in('user[password]', with: 'PassW0rd!123')
  fill_in('user[password_confirmation]', with: 'PassW0rd!123')
  fill_in('user[short_bio]', with: 'A' * 50)
  click_button('Create')
end

Given('User {string} is already registered') do |_email|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('User should be registered succesfully') do
  assert_current_path('/')
  page.should have_content('User created')
end

Then('User should see a message indicating error user is already registered') do
  pending # Write code here that turns the phrase above into concrete actions
end
