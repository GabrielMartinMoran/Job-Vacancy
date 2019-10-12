When('I fill the tags with {string}') do |offer_tags|
  fill_in('job_offer[tags]', with: offer_tags)
end

Then('I should see {string} in tags field for {string} in My Offers') do |_tags, _offer_name|
  pending
end

Then('I should see a message indicating that there is too much tags') do
  pending # Write code here that turns the phrase above into concrete actions
end
