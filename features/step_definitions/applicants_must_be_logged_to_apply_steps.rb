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
  pending # Write code here that turns the phrase above into concrete actions
end

When('applicant navigate to offer apply url') do
  pending # Write code here that turns the phrase above into concrete actions
end
