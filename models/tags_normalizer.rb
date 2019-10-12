class TagsNormalizer
  def self.normalize(tags)
    tags.downcase.delete(' ')
  end
end
