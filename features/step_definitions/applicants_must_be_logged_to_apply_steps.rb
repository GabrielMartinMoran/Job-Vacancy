When('applicant tries to apply') do
  click_link('Apply')
end

Then('applicant should be in offer apply page') do
  assert_current_path("/job_offers/apply/#{@job_offer.id}")
end

Given('applicant is not logged in') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('applicant should be in login page') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('applicant logins') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('applicant registers') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('applicant navigate to offer apply url') do
  pending # Write code here that turns the phrase above into concrete actions
end
