When('applicant tries to apply') do
  click_link('Apply')
end

Then('applicant should be in offer apply page') do
  assert_current_path("/job_offers/apply/#{@job_offer.id}")
end

Given('applicant is not logged in') do
  visit '/logout'
end

Then('applicant should be in login page') do
  assert_current_path('/login', ignore_query: true)
end

When('applicant logins') do
  fill_in('user[email]', with: 'offerer@test.com')
  fill_in('user[password]', with: 'Passw0rd!')
  click_button('Login')
  page.should have_content('offerer@test.com')
end

When('applicant registers') do
  click_link('register')
  fill_in('user[name]', with: 'UserName')
  fill_in('user[email]', with: 'applicantmustbeloggedtoapply@test.com')
  fill_in('user[password]', with: 'PassW0rd!123')
  fill_in('user[password_confirmation]', with: 'PassW0rd!123')
  fill_in('user[short_bio]', with: 'A' * 50)
  click_button('Create')
end

When('applicant navigate to offer apply url') do
  pending # Write code here that turns the phrase above into concrete actions
end
