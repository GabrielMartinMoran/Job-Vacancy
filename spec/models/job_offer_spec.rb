require 'spec_helper'

describe JobOffer do
  subject(:job_offer) { described_class.new({}) }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:location) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:owner) }
    it { is_expected.to respond_to(:owner=) }
    it { is_expected.to respond_to(:created_on) }
    it { is_expected.to respond_to(:updated_on) }
    it { is_expected.to respond_to(:is_active) }
    it { is_expected.to respond_to(:tags) }
    it { is_expected.to respond_to(:applications_quantity) }
    it { is_expected.to respond_to(:users_notified) }
  end

  describe 'valid?' do
    it 'should be invalid when title is blank' do
      job_offer = described_class.new({})
      expect(job_offer).not_to be_valid
      expect(job_offer.errors).to have_key(:title)
    end

    it 'should be valid when title is not blank' do
      job_offer = described_class.new(title: 'a title')
      expect(job_offer).to be_valid
    end
  end

  describe 'initialize' do
    it 'should set users_notified with provided value' do
      job_offer = described_class.new(users_notified: true)
      expect(job_offer.users_notified).to be true
    end

    it 'should set users_notified with false if not provided' do
      job_offer = described_class.new
      expect(job_offer.users_notified).to be false
    end
  end

  describe 'activate' do
    let!(:offer) do
      described_class.new(id: -999,
                          title: 'a title',
                          description: 'a description',
                          location: 'a location')
    end

    it 'should deliver offer info notification when users_notified is false' do
      users_to_notify = [User.new(email: 'user_notify_1@test.com'),
                         User.new(email: 'user_notify_2@test.com')]
      expect(JobVacancy::App).to receive(:deliver).twice
      offer.activate(users_to_notify)
      expect(offer.users_notified).to be true
      expect(offer.is_active).to be true
    end

    it 'should not deliver emails if users_notified is false and there is no users to notify' do
      expect(JobVacancy::App).not_to receive(:deliver)
      offer.activate
      expect(offer.users_notified).to be true
      expect(offer.is_active).to be true
    end

    it 'should not deliver offer info notification when users_notified is true' do
      offer.users_notified = true
      users_to_notify = [User.new(email: 'user_notify_1@test.com'),
                         User.new(email: 'user_notify_2@test.com')]
      expect(JobVacancy::App).not_to receive(:deliver)
      offer.activate(users_to_notify)
      expect(offer.users_notified).to be true
      expect(offer.is_active).to be true
    end
  end
end
