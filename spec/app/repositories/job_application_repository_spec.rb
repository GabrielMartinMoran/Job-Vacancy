require 'integration_spec_helper'

describe JobApplicationRepository do
  let(:repository) { described_class.new }

  let(:owner) do
    user = User.new(name: 'jobapplicationrepouser', email: 'jobapplicationrepouser@doe.com',
                    crypted_password: 'secure_pwd', short_bio: 'A' * 50)
    UserRepository.new.save(user)
    user
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
    job_application = JobApplication.new(applicant_email: 'applicant@test.com',
                                         expected_remuneration: 9999.9,
                                         job_offer: offer)
    repository.save(job_application)
    job_application
  end

  describe 'find' do
    it 'job application should be obtained if saved in database' do
      obtained = repository.find(job_application.id)
      expect(obtained.applicant_email).to eq job_application.applicant_email
      expect(obtained.expected_remuneration).to eq job_application.expected_remuneration
      expect(obtained.job_offer.id).to eq job_application.job_offer.id
    end
  end
end
