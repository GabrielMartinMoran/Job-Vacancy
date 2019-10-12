require 'rspec'
require_relative '../../models/tags_normalizer'

describe TagsNormalizer do
  context 'when normalize' do
    it 'should return empty string when tags is empty string' do
      expect(described_class.normalize('')).to eq ''
    end

    it 'should return "tag1" when tags is "tag1"' do
      expect(described_class.normalize('tag1')).to eq 'tag1'
    end

    it 'should return "tag1" when tags is "Tag1"' do
      expect(described_class.normalize('Tag1')).to eq 'tag1'
    end
  end
end
