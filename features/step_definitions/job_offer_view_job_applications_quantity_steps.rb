Given('{int} users apply to {string} offer') do |_quantity, _job_title|
end

When('I access to my offers page') do
  visit '/job_offers/my'
end

Then('I should see {int} job applications for {string} offer') do |quantity, job_title|
  page.should have_content(job_title)
  page.should have_content(quantity)
end
