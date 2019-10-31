When('applicant applies with expected remuneration {float}') do |expected_remuneration|
  click_link 'Apply'
  fill_in('job_application[expected_remuneration]', with: expected_remuneration)
  click_button('Apply')
end

Then('applicant email and expected remuneration {float} should be stored for {string} offer') do |expected_remuneration, job_offer_title|
  job_offer = JobOfferRepository.new.search_by_title(job_offer_title).first
  job_application = JobApplicationRepository.new.find_by_job_offer_id(job_offer.id).first
  expect(job_application.applicant.email).to eq @logged_user.email
  expect(job_application.expected_remuneration).to eq expected_remuneration
end
