When('I fill email with {string} and other fields with valid values') do |email|
  @email = email
  fill_in('user[name]', with: 'UserName')
  fill_in('user[email]', with: @email)
  fill_in('user[password]', with: 'PassW0rd!123')
  fill_in('user[password_confirmation]', with: 'PassW0rd!123')
  short_bio = 'A' * 50
  fill_in('user[short_bio]', with: short_bio)
end

When('I click create') do
  click_button('Create')
end

Then('I should be logged in') do
  assert_current_path('/')
  page.should have_content(@email)
end
