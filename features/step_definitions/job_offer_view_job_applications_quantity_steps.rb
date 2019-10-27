Given('{int} users apply to {string} offer') do |quantity, _job_title|
  ja_repository = JobApplicationRepository.new
  quantity.times do |i|
    applicant = User.new(name: "applicant_#{i}", email: "applicant_#{i}@test.com",
                         crypted_password: 'secure_pwd', short_bio: 'A' * 50)
    UserRepository.new.save(applicant)
    ja = JobApplication.new(applicant_email: "applicant_#{i}@test.com", job_offer: @job_offer,
                            applicant: applicant)
    ja_repository.save(ja)
  end
end

When('I access to my offers page') do
  visit '/job_offers/my'
end

Then('I should see {int} job applications for {string} offer') do |quantity, job_title|
  page.should have_content(job_title)
  page.should have_content('Applications quantity')
  page.should have_content(quantity)
end
