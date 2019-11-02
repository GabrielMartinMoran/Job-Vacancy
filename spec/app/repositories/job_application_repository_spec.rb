require 'integration_spec_helper'

describe JobApplicationRepository do
  let(:repository) { described_class.new }

  let(:owner) do
    user = User.new(name: 'jobapplicationrepouser', email: 'jobapplicationrepouser@doe.com',
                    crypted_password: 'secure_pwd', short_bio: 'A' * 50)
    UserRepository.new.save(user)
    user
  end

  let(:applicant) do
    applicant = User.new(name: 'applicant_user', email: 'applicant_user@doe.com',
                         crypted_password: 'secure_pwd', short_bio: 'A' * 50)
    UserRepository.new.save(applicant)
    applicant
  end

  let!(:offer) do
    offer = JobOffer.new(title: 'a title',
                         updated_on: Date.today,
                         is_active: true,
                         user_id: owner.id)
    JobOfferRepository.new.save(offer)
    offer
  end

  let!(:job_application) do
    job_application = JobApplication.new(applicant: applicant,
                                         expected_remuneration: 9999.9,
                                         job_offer: offer)
    repository.save(job_application)
    job_application
  end

  describe 'find' do
    it 'job application should be obtained if saved in database' do
      obtained = repository.find(job_application.id)
      expect(obtained.expected_remuneration).to eq job_application.expected_remuneration
      expect(obtained.job_offer.id).to eq job_application.job_offer.id
      expect(obtained.applicant.id).to eq job_application.applicant.id
    end
  end

  describe 'find_by_job_offer_id' do
    let(:applications_mock_array) do
      applications_mock_array = [
        JobApplication.new,
        JobApplication.new,
        JobApplication.new
      ]
      applications_mock_array[0].created_on = Date.new(2019, 5, 2)
      applications_mock_array[1].created_on = Date.new(2017, 6, 9)
      applications_mock_array[2].created_on = Date.new(2018, 9, 12)
      applications_mock_array
    end

    it 'should return empty array if there is no job applications for provided job_offer_id' do
      obtained = repository.find_by_job_offer_id(-99_999)
      expect(obtained).to eq []
    end

    it 'should return job application object if exists with provided job_offer_id' do
      obtained = repository.find_by_job_offer_id(offer.id).first
      expect(obtained.expected_remuneration).to eq job_application.expected_remuneration
      expect(obtained.job_offer.id).to eq job_application.job_offer.id
      expect(obtained.applicant.id).to eq job_application.applicant.id
    end

    it 'should return job applications objects sorteds by created_on date' do
      allow(repository).to receive(:load_collection).and_return(applications_mock_array)
      obtained = repository.find_by_job_offer_id(offer.id)
      expect(obtained[0].created_on).to eq Date.new(2017, 6, 9)
      expect(obtained[1].created_on).to eq Date.new(2018, 9, 12)
      expect(obtained[2].created_on).to eq Date.new(2019, 5, 2)
    end
  end
end
