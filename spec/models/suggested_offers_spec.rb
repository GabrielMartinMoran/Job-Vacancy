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
  end
end
