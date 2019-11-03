When('I try to register with prefered tags {string}') do |prefered_tags|
  @email = 'register_tags@test.com'
  fill_in('user[name]', with: 'UserName')
  fill_in('user[email]', with: @email)
  fill_in('user[password]', with: 'PassW0rd!123')
  fill_in('user[password_confirmation]', with: 'PassW0rd!123')
  short_bio = 'A' * 50
  fill_in('user[short_bio]', with: short_bio)
  fill_in('user[prefered_tags]', with: prefered_tags)
  click_button('Create')
end

Then('I should be registered succesfully') do
  page.should have_content(@email)
end

Then('I should see a message indicating error on prefered tags') do
  page.should have_content('Too much prefered tags')
end

Given('User {string} is registered with prefered tags {string}') do |email, prefered_tags|
  @user = User.new(name: 'John Doe',
                   email: email,
                   password: 'PassW0rd!123',
                   short_bio: 'A' * 50,
                   prefered_tags: prefered_tags)

  UserRepository.new.save @user
end

When('Job Offer is first time activated') do
  @job_offer.deactivate
  repository = JobOfferRepository.new
  repository.save @job_offer
  visit '/login'
  fill_in('user[email]', with: @job_offer.owner.email)
  fill_in('user[password]', with: @job_offerer_password)
  click_button('Login')
  visit '/job_offers/my'
  click_button('Activate offer')
  jo = repository.find(@job_offer.id)
  expect(jo.is_active).to be true
end

Then('User receive email with Job Offer info') do
  mail_store = "#{Padrino.root}/tmp/emails"
  path = "#{mail_store}/#{@user.email}"
  file = File.open(path, 'r')
  content = file.read
  content.include?(@job_offer.title).should be true
  content.include?(@job_offer.location).should be true
  content.include?(@job_offer.description).should be true
  content.include?("/job_offers/apply/#{@job_offer.id}").should be true
  file.close
  File.delete(path) if File.exist?(path)
end

Given('Job Offer was already activated') do
  @job_offer.users_notified = true
  @job_offer.is_active = true
  JobOfferRepository.new.save @job_offer
end

When('Job Offer is deactivated') do
  @job_offer.is_active = false
  JobOfferRepository.new.save @job_offer
end

When('Job Offer is activated') do
  visit '/login'
  fill_in('user[email]', with: @job_offer.owner.email)
  fill_in('user[password]', with: @job_offerer_password)
  click_button('Login')
  visit '/job_offers/my'
  click_button('Activate offer')
  jo = JobOfferRepository.new.find(@job_offer.id)
  expect(jo.is_active).to be true
end

Then('User should not receive an email with Job Offer info') do
  mail_store = "#{Padrino.root}/tmp/emails"
  path = "#{mail_store}/#{@user.email}"
  expect(File.exist?(path)).to be false
end
