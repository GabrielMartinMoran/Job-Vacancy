require_relative 'tags_normalizer'

MAX_TAGS_QUANTITY = 3

class JobOffer
  include ActiveModel::Validations

  attr_accessor :id, :user, :user_id, :title,
                :location, :description, :is_active,
                :updated_on, :created_on, :tags,
                :applications_quantity, :users_notified

  attr_reader :has_valid_tags

  validates :title, presence: true

  # rubocop:disable Metrics/AbcSize
  def initialize(data = {})
    @id = data[:id]
    @title = data[:title]
    @location = data[:location]
    @description = data[:description]
    @is_active = data[:is_active]
    @updated_on = data[:updated_on]
    @created_on = data[:created_on]
    @user_id = data[:user_id]
    parse_tags(data[:tags])
    @applications_quantity = data[:applications_quantity] || 0
    @users_notified = data[:users_notified] || false
  end
  # rubocop:enable Metrics/AbcSize

  def parse_tags(tags)
    @has_valid_tags = true
    @tags = TagsNormalizer.new(MAX_TAGS_QUANTITY).normalize(tags || '')
  rescue StandardError
    @has_valid_tags = false
    errors.add(:tags, 'Too much tags')
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
