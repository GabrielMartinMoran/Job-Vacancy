Given('{string} offer exists in the offers list with tags {string}') do |offer, offer_tags|
  @job_offer = JobOffer.new
  @job_offer.owner = UserRepository.new.first
  @job_offer.title = offer
  @job_offer.location = 'a nice job'
  @job_offer.description = 'a nice job'
  @job_offer.tags = offer_tags
  @job_offer.is_active = true

  JobOfferRepository.new.save @job_offer
end

When('I apply to {string} offer') do |_string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see {int} suggested offers') do |_int|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('Suggested offer link should redirect to suggested offer apply page') do
  pending # Write code here that turns the phrase above into concrete actions
end
