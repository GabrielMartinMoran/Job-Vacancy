require 'spec_helper'

describe JobApplication do
  describe 'model' do
    it { is_expected.to respond_to(:applicant_email) }
    it { is_expected.to respond_to(:job_offer) }
    it { is_expected.to respond_to(:expected_remuneration) }
  end

  describe 'create_for' do
    it 'should set applicant_email' do
      email = 'applicant@test.com'
      ja = described_class.create_for(email, JobOffer.new)
      expect(ja.applicant_email).to eq(email)
    end

    it 'should set job_offer' do
      offer = JobOffer.new
      ja = described_class.create_for('applicant@test.com', offer)
      expect(ja.job_offer).to eq(offer)
    end

    it 'expected remuneration should be 1000 if is 1000' do
      offer = JobOffer.new
      ja = described_class.create_for('applicant@test.com', offer, 1000)
      expect(ja.expected_remuneration).to eq(1000)
    end

    it 'should raise exception if expected_remuneration is negative' do
      offer = JobOffer.new
      expect { described_class.create_for('applicant@test.com', offer, -1000) }.to raise_exception
    end

    it 'should raise exception if expected_remuneration is not a number' do
      offer = JobOffer.new
      expect { described_class.create_for('applicant@test.com', offer, 'a') }.to raise_exception
    end

    it 'expected remuneration should be "Not specified" if is an empty string' do
      offer = JobOffer.new
      ja = described_class.create_for('applicant@test.com', offer, '')
      expect(ja.expected_remuneration).to eq('Not specified')
    end
  end

  describe 'process' do
    it 'should deliver contact info notification' do
      ja = described_class.create_for('applicant@test.com', JobOffer.new)
      expect(JobVacancy::App).to receive(:deliver).with(:notification, :contact_info_email, ja)
      ja.process
    end
  end
end
