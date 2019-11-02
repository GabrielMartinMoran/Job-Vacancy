Given('I applied for Job Offer with expected remuneration {float}') do |expected_remuneration|
  visit "/job_offers/apply/#{@job_offer.id}"
  fill_in('job_application[expected_remuneration]', with: expected_remuneration)
  click_button('Apply')
end

When('I access to my applications') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see Job Offer application info') do
  pending # Write code here that turns the phrase above into concrete actions
end
