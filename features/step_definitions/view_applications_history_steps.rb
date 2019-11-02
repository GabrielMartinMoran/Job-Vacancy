Given('I applied for Job Offer with expected remuneration {float}') do |expected_remuneration|
  visit "/job_offers/apply/#{@job_offer.id}"
  fill_in('job_application[expected_remuneration]', with: expected_remuneration)
  click_button('Apply')
end

When('I access to my applications') do
  click_link('My Applications')
  page.should have_content('My applications')
  page.should have_content('Apply date')
  page.should have_content('Title')
  page.should have_content('Expected remuneration')
  page.should have_content('Offerer email')
end

Then('I should see Job Offer application info') do
  pending # Write code here that turns the phrase above into concrete actions
end
