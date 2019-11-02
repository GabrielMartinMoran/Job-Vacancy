When('I try to register with prefered tags {string}') do |prefered_tags|
  fill_in('user[name]', with: 'UserName')
  fill_in('user[email]', with: 'register_tags@test.com')
  fill_in('user[password]', with: 'PassW0rd!123')
  fill_in('user[password_confirmation]', with: 'PassW0rd!123')
  short_bio = 'A' * 50
  fill_in('user[short_bio]', with: short_bio)
  fill_in('user[prefered_tags]', with: prefered_tags)
end

Then('I should be registered succesfully') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see a message indicating error on prefered tags') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('User {string} is registered with prefered tags {string}') do |_string, _string2|
  pending # Write code here that turns the phrase above into concrete actions
end

When('Job Offer is first time activated') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('User receive email with Job Offer info') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('Job Offer was already activated') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('Job Offer is deactivated') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('Job Offer is activated') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('User should not receive an email with Job Offer info') do
  pending # Write code here that turns the phrase above into concrete actions
end
