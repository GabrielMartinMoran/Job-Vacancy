Given('I access to the register page') do
  visit '/register'
end

When('I fill password with {string} and password confirmation with {string}') do |password, password_confirmation|
  @password = password
  fill_in('user[password]', with: password)
  fill_in('user[password_confirmation]', with: password_confirmation)
end

When('I try to register') do
  fill_in('user[name]', with: 'UserName')
  fill_in('user[email]', with: 'StrongPasswordUser@test.com')
  fill_in('user[short_bio]', with: 'A' * 50)
  click_button('Create')
end

Then('I should be able to login') do
  visit '/login'
  fill_in('user[email]', with: 'StrongPasswordUser@test.com')
  fill_in('user[password]', with: @password)
  click_button('Login')
  assert_current_path('/')
  page.should have_content('StrongPasswordUser@test.com')
end
