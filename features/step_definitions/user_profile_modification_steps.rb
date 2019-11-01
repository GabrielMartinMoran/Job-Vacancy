Given('I am logged in as {string}') do |email|
  repository = UserRepository.new
  @logged_user = User.new(email: email,
                          name: 'UserName',
                          password: 'Passw0rd!',
                          short_bio: 'A' * 50)
  repository.save(@logged_user)
  visit '/login'
  fill_in('user[email]', with: email)
  fill_in('user[password]', with: 'Passw0rd!')
  click_button('Login')
  page.should have_content(email)
end

When('I click on email link') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should be in profile update page') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I am in profile update page') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('I update my name, short bio and prefered tags') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('I click on save button') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('My profile should be updated') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('My password should be not updated') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('I update my password and password confirmation') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('My password should be updated') do
  pending # Write code here that turns the phrase above into concrete actions
end
