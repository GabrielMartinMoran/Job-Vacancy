require 'rspec'
require_relative '../../models/taggable'

describe Taggable do
  class TaggableDummy
    include Taggable
  end

  let(:taggable_dummy) do
    TaggableDummy.new
  end

  describe 'parse_tags' do
    it 'should return empty string when raw_tags is nil' do
      expect(taggable_dummy.parse_tags(nil, 1)).to eq ''
    end

    it 'should return normalized tags string when raw_tags is provided and max_tags is 3' do
      expect(taggable_dummy.parse_tags(' Tag1, tag1, TaG2 , Tag3', 3)).to eq 'tag1,tag2,tag3'
    end

    it 'should set has_valid_tags to true when tags are parsed correctly' do
      expect(taggable_dummy.parse_tags('tag1', 1)).to eq 'tag1'
      expect(taggable_dummy.has_valid_tags).to be true
    end

    it 'should set has_valid_tags to false when tags are not parsed correctly' do
      expect(taggable_dummy.parse_tags('tag1,tag2', 1)).to be nil
      expect(taggable_dummy.has_valid_tags).to be false
    end
  end
end
