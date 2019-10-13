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
  mail_store = "#{Padrino.root}/tmp/emails"
  file = File.open("#{mail_store}/#{@job_offer.owner.email}", 'r')
  @mail_content = file.read
  @mail_content.include?("Application for offer #{@job_offer.id}").should be true
  @mail_content.include?('applicant@test.com').should be true
  @mail_content.include?(@job_offer.title).should be true
  @mail_content.include?(@job_offer.location).should be true
  @mail_content.include?(@job_offer.description).should be true
end

Then('expected remuneration in mail is {string}') do |expected_remuneration|
  @mail_content.include?(expected_remuneration).should be true
end

Then('I should see a message indicating error on expected remuneration') do
  pending # Write code here that turns the phrase above into concrete actions
end
