class TagsNormalizer
  def self.normalize(tags)
    tags.downcase.delete(' ').split(',').reject(&:empty?).join(',')
  end
end
