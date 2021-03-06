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

Then('I should see a label {string} in my offers for this offer') do |label|
  visit '/job_offers/my'
  page.should have_content(label)
end

Then('I should not see a label {string} in my offers for this offer') do |label|
  visit '/job_offers/my'
  page.should_not have_content(label)
end

When('I try to access to {string} the offer page') do |job_offer|
  job_offer_id = JobOfferRepository.new.search_by_title(job_offer).first.id
  visit '/job_offers/apply/' + job_offer_id.to_s
end

Then('I should see a message indicating expired offer') do
  page.should have_content('This Job Offer has expired')
end
