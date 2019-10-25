Given('{int} users apply to {string} offer') do |_quantity, _job_title|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I access to my offers page') do
  visit path_to('/job_offers/my_offers')
end

Then('I should see {int} job applications for {string} offer') do |_quantity, _job_title|
  pending # Write code here that turns the phrase above into concrete actions
end
