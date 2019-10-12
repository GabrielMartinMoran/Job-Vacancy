Given('User acceses to the register page') do
  visit '/register'
end

When('User fills email with {string} and password, password confirmation and name with valid values') do |_email|
  pending # Write code here that turns the phrase above into concrete actions
end

When('User fills short bio with a text of {int} characters length') do |_bio_length|
  pending # Write code here that turns the phrase above into concrete actions
end

When('User tries to register') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('User should be able to login with email {string}') do |_email|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('User should see a message indicating error on short bio') do
  pending # Write code here that turns the phrase above into concrete actions
end
