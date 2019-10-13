When('I try to apply') do
  visit '/job_offers'
  click_link 'Apply'
  fill_in('job_application[applicant_email]', with: 'applicant@test.com')
end

When('I fill expected remuneration with {float}') do |expected_remuneration|
  fill_in('job_application[expected_remuneration]', with: expected_remuneration)
end

When('I submit application') do
  click_button('Apply')
end

Then('the job offerer receive a mail with application info') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('expected remuneration in mail is {string}') do |_string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see a message indicating error on expected remuneration') do
  pending # Write code here that turns the phrase above into concrete actions
end
