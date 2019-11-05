When('And I fill max valid date with {string} date') do |date|
  dates = { 'tomorrow' => Date.today + 1, 'yesterday' => Date.today - 1 }
  fill_in('job_offer[max_valid_date]', with: dates[date].to_s)
end

When('I active the offer') do
  visit '/job_offers/my'
  click_button('Activate offer')
end

Then('I should see {string} in Offers list') do |job_offer_title|
  visit '/job_offers/latest'
  page.should have_content(job_offer_title)
end

Then('I should not see {string} in Offers list') do |job_offer_title|
  visit '/job_offers/latest'
  page.should_not have_content(job_offer_title)
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
