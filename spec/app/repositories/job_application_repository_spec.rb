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

  describe 'find' do
    it 'job application should be obtained if saved in database' do
      ja = JobApplication.new(applicant_email: 'applicant@test.com', expected_remuneration: 9999.9,
                              job_offer: offer)
      repository.save(ja)

      obtained = repository.find(ja.id)
      expect(obtained.applicant_email).to eq ja.applicant_email
    end
  end
end
