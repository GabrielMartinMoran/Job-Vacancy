require_relative 'tags_normalizer'

module Tageable
  def parse_tags(raw_tags, max_tags)
    TagsNormalizer.new(max_tags).normalize(raw_tags || '')
  end
end
