When('I fill the tags with {string}') do |offer_tags|
  fill_in('job_offer[tags]', with: offer_tags)
end

Then('I should see {string} in tags field for {string} in My Offers') do |tags, offer_name|
  page.should have_content('Tags')
  page.should have_content(tags)
  page.should have_content(offer_name)
end

Then('I should see a message indicating that there is too much tags') do
  page.should have_content('Too much tags')
end
