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
      expect(tageable_dummy.parse_tags(nil)).to eq ''
    end
  end
end
