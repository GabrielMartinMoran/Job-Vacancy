When('I try to apply') do
  visit '/job_offers'
  click_link 'Apply'
  fill_in('job_application[applicant_email]', with: 'applicant@test.com')
end

When('I fill expected remuneration with {int}') do |_int|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I submit application') do
  pending # Write code here that turns the phrase above into concrete actions
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
