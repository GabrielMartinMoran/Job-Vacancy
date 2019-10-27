require 'spec_helper'

describe JobApplication do
  subject(:job_application) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:applicant_email) }
    it { is_expected.to respond_to(:job_offer) }
    it { is_expected.to respond_to(:job_offer_id) }
    it { is_expected.to respond_to(:expected_remuneration) }
    it { is_expected.to respond_to(:created_on) }
    it { is_expected.to respond_to(:updated_on) }
    it { is_expected.to respond_to(:applicant) }
    it { is_expected.to respond_to(:applicant_id) }
  end

  describe 'initialize' do
    it 'should set applicant_email' do
      email = 'applicant@test.com'
      ja = described_class.new(applicant_email: email, job_offer: JobOffer.new)
      expect(ja.applicant_email).to eq(email)
    end

    it 'should set job_offer' do
      offer = JobOffer.new
      ja = described_class.new(applicant_email: 'applicant@test.com', job_offer: offer)
      expect(ja.job_offer).to eq(offer)
    end

    it 'expected remuneration should be 1000 if is 1000' do
      offer = JobOffer.new
      ja = described_class.new(applicant_email: 'applicant@test.com', job_offer: offer,
                               expected_remuneration: 1000)
      expect(ja.expected_remuneration).to eq(1000)
    end

    it 'should raise exception if expected_remuneration is negative' do
      offer = JobOffer.new
      expect do
        described_class.new(applicant_email: 'applicant@test.com', job_offer: offer,
                            expected_remuneration: -1000)
      end .to raise_exception
    end

    it 'should raise exception if expected_remuneration is zero' do
      offer = JobOffer.new
      expect do
        described_class.new(applicant_email: 'applicant@test.com', job_offer: offer,
                            expected_remuneration: 0)
      end .to raise_exception
    end

    it 'should raise exception if expected_remuneration is not a number' do
      offer = JobOffer.new
      expect do
        described_class.new(applicant_email: 'applicant@test.com', job_offer: offer,
                            expected_remuneration: 'a')
      end .to raise_exception
    end

    it 'expected remuneration should be nil if is not provided' do
      offer = JobOffer.new
      ja = described_class.new(applicant_email: 'applicant@test.com', job_offer: offer)
      expect(ja.expected_remuneration).to eq(nil)
    end
  end

  describe 'process' do
    it 'should send contact info and applicant apply emails' do
      ja = described_class.new(applicant_email: 'applicant@test.com', job_offer: JobOffer.new)
      expect(JobVacancy::App).to receive(:deliver).twice
      ja.process
    end
  end

  describe 'deliver_contact_info_email' do
    it 'should deliver contact info notification' do
      ja = described_class.new(applicant_email: 'applicant@test.com', job_offer: JobOffer.new)
      expect(JobVacancy::App).to receive(:deliver).with(:notification, :contact_info_email, ja)
      ja.deliver_contact_info_email
    end
  end

  describe 'deliver_applicant_apply_email' do
    it 'should deliver applicant apply notification' do
      ja = described_class.new(applicant_email: 'applicant@test.com', job_offer: JobOffer.new)
      expect(JobVacancy::App).to receive(:deliver).with(:notification, :applicant_apply_email, ja)
      ja.deliver_applicant_apply_email
    end
  end
end
