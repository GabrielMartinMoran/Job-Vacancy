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
  job_application = JobApplicationRepository.new
                                            .find_by_applicant_id(@logged_user.id).first
  page.should have_content(job_application.created_on.to_s)
  page.should have_content(job_application.job_offer.title)
  page.should have_content(job_application.expected_remuneration)
  page.should have_content(job_application.job_offer.owner.email)
end
