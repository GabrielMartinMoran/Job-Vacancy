require 'rspec'
require_relative '../../models/suggested_offers'

describe SuggestedOffers do
  subject(:suggested_offers) do
    described_class.new(JobOffer.new(title: 'a title', tags: 'programmer,web,ruby'))
  end

  context 'when obtain' do
    it 'should return empty array when suggested_offers is created' do
      expect(suggested_offers.obtain).to eq []
    end

    it 'should return empty array when none offer match tags' do
      job_offer = JobOffer.new(title: 'a title', tags: '')
      suggested_offers.add([job_offer])
      expect(suggested_offers.obtain).to eq []
    end

    it 'should return one offer in array when one offer match tags' do
      job_offer = JobOffer.new(title: 'a title', tags: 'programmer,web,ruby')
      suggested_offers.add([job_offer])
      expect(suggested_offers.obtain).to eq [job_offer]
    end

    it 'should return one offer in array when one offer match some tag' do
      job_offer = JobOffer.new(title: 'a title', tags: 'ruby')
      suggested_offers.add([job_offer])
      expect(suggested_offers.obtain).to eq [job_offer]
    end

    it 'should return two offers in array when two offers match some tags' do
      job_offer1 = JobOffer.new(title: 'a title', tags: 'ruby')
      job_offer2 = JobOffer.new(title: 'a title', tags: 'programmer')
      suggested_offers.add([job_offer1, job_offer2])
      expect(suggested_offers.obtain).to include(job_offer1, job_offer2)
    end

    it 'should return three offers in array when three offers match some tags' do
      job_offer1 = JobOffer.new(title: 'a title', tags: 'ruby')
      job_offer2 = JobOffer.new(title: 'a title', tags: 'programmer')
      job_offer3 = JobOffer.new(title: 'a title', tags: 'programmer')
      suggested_offers.add([job_offer1, job_offer2, job_offer3])
      expect(suggested_offers.obtain).to include(job_offer1, job_offer2, job_offer3)
    end

    it 'should return only three offers in array when four offers match some tags' do
      job_offer1 = JobOffer.new(title: 'a title', tags: 'ruby')
      job_offer2 = JobOffer.new(title: 'a title', tags: 'programmer')
      job_offer3 = JobOffer.new(title: 'a title', tags: 'web')
      job_offer4 = JobOffer.new(title: 'a title', tags: 'programmer')
      suggested_offers.add([job_offer1, job_offer2, job_offer3, job_offer4])
      expect(suggested_offers.obtain.size).to eq(3)
    end
  end
end
