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
  click_link(@logged_user.email)
end

Then('I should be in profile update page') do
  assert_current_path('/profile_update')
  page.should have_content('Edit profile')
  page.should have_content('Name')
  page.should have_content('Email')
  page.should have_content('Password')
  page.should have_content('Password confirmation')
  page.should have_content('Short bio')
end

Given('I am in profile update page') do
  visit '/profile_update'
end

When('I update my name, short bio and prefered tags') do
  fill_in('user[name]', with: 'NewName')
  fill_in('user[short_bio]', with: 'B' * 50)
  # pending prefered tags
  # fill_in('user[prefered_tags]', with: 'NewName')
end

When('I click on save button') do
  click_button('Save')
end

Then('My profile should be updated') do
  obtained_user = UserRepository.new.find(@logged_user.id)
  expect(obtained_user.email).to eq @logged_user.email
  expect(obtained_user.name).not_to eq @logged_user.name
  expect(obtained_user.short_bio).not_to eq @logged_user.short_bio
end

Then('My password should be not updated') do
  obtained_user = UserRepository.new.find(@logged_user.id)
  expect(obtained_user.crypted_password).to eq @logged_user.crypted_password
end

When('I update my password and password confirmation') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('My password should be updated') do
  pending # Write code here that turns the phrase above into concrete actions
end
