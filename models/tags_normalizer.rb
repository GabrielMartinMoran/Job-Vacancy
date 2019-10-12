class TagsNormalizer
  def initialize(max_tags)
    @max_tags = max_tags
  end

  def normalize(tags)
    normalized_array = tags.downcase.delete(' ').split(',').reject(&:empty?).uniq

    raise StandardError, 'Too much tags' if normalized_array.length > @max_tags

    normalized_array.join(',')
  end
end
