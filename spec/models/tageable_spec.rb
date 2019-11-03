require 'rspec'
require_relative '../../models/tageable'

describe Tageable do
  class TageableDummy
    include Tageable
  end

  let(:tageable_dummy) do
    TageableDummy.new
  end

  describe 'parse_tags' do
    it 'should return empty string when raw_tags is nil' do
      expect(tageable_dummy.parse_tags(nil, 1)).to eq ''
    end

    it 'should return normalized tags string when raw_tags is provided and max_tags is 3' do
      expect(tageable_dummy.parse_tags(' Tag1, tag1, TaG2 , Tag3', 3)).to eq 'tag1,tag2,tag3'
    end
  end
end
