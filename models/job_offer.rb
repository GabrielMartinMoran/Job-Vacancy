require_relative 'tags_normalizer'

MAX_TAGS_QUANTITY = 3

class JobOffer
  include ActiveModel::Validations

  attr_accessor :id, :user, :user_id, :title,
                :location, :description, :is_active,
                :updated_on, :created_on, :tags

  validates :title, presence: true

  def initialize(data = {})
    @id = data[:id]
    @title = data[:title]
    @location = data[:location]
    @description = data[:description]
    @is_active = data[:is_active]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @user_id = data[:user_id]
    @tags = TagsNormalizer.new(MAX_TAGS_QUANTITY).normalize(data[:tags] || '')
  end

  def owner
    user
  end

  def owner=(a_user)
    self.user = a_user
  end

  def activate
    self.is_active = true
  end

  def deactivate
    self.is_active = false
  end

  def old_offer?
    (Date.today - updated_on) >= 30
  end
end
