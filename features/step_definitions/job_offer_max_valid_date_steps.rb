When('And I fill max valid date with {string} date') do |date|
  dates = { 'Tomorrow' => Date.today + 1, 'Yesterday' => Date.today - 1 }
  fill_in('job_offer[max_valid_date]', with: dates[date])
end

Then('I should see {string} in Offers list') do |_job_offer|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should not see {string} in Offers list') do |_job_offer|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see a label {string} in my offers for this offer') do |_label|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I try to access to {string} the offer page') do |_job_offer|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see a message indicating expired offer') do
  pending # Write code here that turns the phrase above into concrete actions
end
