When('Applicant {string} applies with expected remuneration {float}') do |email, expected_remuneration|
  click_link 'Apply'
  fill_in('job_application[applicant_email]', with: email)
  fill_in('job_application[expected_remuneration]', with: expected_remuneration)
  click_button('Apply')
end

Then('Email {string} and expected remuneration {float} should be stored for {string} offer') do |_email, _expected_remuneration, _job_offer_title|
  # job_offer = JobOfferRepository.new.search_by_title(job_offer_title).first
  pending
end
