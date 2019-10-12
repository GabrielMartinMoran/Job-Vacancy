require 'rspec'
require_relative '../../models/tags_normalizer'

describe TagsNormalizer do
  context 'when normalize' do
    it 'should return empty string when tags is empty string' do
      expect(described_class.normalize('')).to eq ''
    end
  end
end
