class TagsNormalizer
  def initialize(_max_tags); end

  def normalize(tags)
    tags.downcase.delete(' ').split(',').reject(&:empty?).join(',')
  end
end
