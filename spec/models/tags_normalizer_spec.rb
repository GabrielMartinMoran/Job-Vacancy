require 'rspec'
require_relative '../../models/tags_normalizer'

MAX_TAGS_QUANTITY = 3

describe TagsNormalizer do
  subject(:tags_normalizer) { described_class.new(MAX_TAGS_QUANTITY) }

  context 'when normalize' do
    it 'should return empty string when tags is empty string' do
      expect(tags_normalizer.normalize('')).to eq ''
    end

    it 'should return "tag1" when tags is "tag1"' do
      expect(tags_normalizer.normalize('tag1')).to eq 'tag1'
    end

    it 'should return "tag1" when tags is "Tag1"' do
      expect(tags_normalizer.normalize('Tag1')).to eq 'tag1'
    end

    it 'should return "tag1,tag2" when tags is "tag1, tag2"' do
      expect(tags_normalizer.normalize('tag1, tag2')).to eq 'tag1,tag2'
    end

    it 'should return "tag1,tag2" when tags is ",tag1,tag2,"' do
      expect(tags_normalizer.normalize(',tag1,tag2,')).to eq 'tag1,tag2'
    end

    it 'should return "tag1,tag2" when tags is "tag1,tag2,tag1"' do
      expect(tags_normalizer.normalize('tag1,tag2,tag1')).to eq 'tag1,tag2'
    end

    it 'should raise exception when normalized tags are greater than max defined tags' do
      expect { tags_normalizer.normalize('tag1,tag2,tag3,tag4') }.to raise_exception
    end
  end
end
