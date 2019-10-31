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

When('I apply to {string} offer') do |offer|
  job_offer_id = JobOfferRepository.new.search_by_title(offer).first.id
  visit '/job_offers/apply/' + job_offer_id.to_s
end

Then('I should see {int} suggested offers') do |quantity|
  page.should have_content('Apply', count: quantity)
end

Then('Suggested offer link should redirect to suggested offer apply page') do
  click_link('Apply')
  assert_current_path("/job_offers/apply/#{@job_offer.id}")
end
