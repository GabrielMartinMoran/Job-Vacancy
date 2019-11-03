require_relative 'tags_normalizer'

module Tageable
  attr_accessor :has_valid_tags
  def parse_tags(raw_tags, max_tags)
    @has_valid_tags = true
    TagsNormalizer.new(max_tags).normalize(raw_tags || '')
  end
end
