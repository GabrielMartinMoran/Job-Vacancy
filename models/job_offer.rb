require_relative 'taggable'

MAX_TAGS_QUANTITY = 3

class JobOffer
  include ActiveModel::Validations
  include Taggable

  attr_accessor :id, :user, :user_id, :title, :location, :description, :is_active, :updated_on, :created_on, :tags,
                :applications_quantity, :users_notified, :max_valid_date

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
    @tags = parse_tags(data[:tags], MAX_TAGS_QUANTITY)
    @applications_quantity = data[:applications_quantity] || 0
    @users_notified = data[:users_notified] || false
    @max_valid_date = data[:max_valid_date]
  end

  def owner
    user
  end

  def owner=(a_user)
    self.user = a_user
  end

  def activate(users_to_notify = [])
    self.is_active = true
    return if @users_notified

    deliver_offer_notification_email(users_to_notify)
    @users_notified = true
  end

  def deactivate
    self.is_active = false
  end

  def old_offer?
    (Date.today - updated_on) >= 30
  end

  def tags_list
    @tags.split(',')
  end

  def valid?
    valid = true
    unless max_valid_date.nil?
      unless Date.valid_date?(max_valid_date.year, max_valid_date.month, max_valid_date.day)
        errors.add(:tags, 'Invalid Date')
        valid = false
      end
    end
    unless @has_valid_tags
      errors.add(:tags, 'Too much tags')
      valid = false
    end
    return false unless valid

    super
  end

  def showable?
    !expired? && @is_active == true
  end

  def expired?
    (!@max_valid_date.nil? && @max_valid_date < Date.today)
  end

  private

  def deliver_offer_notification_email(users_to_notify)
    users_to_notify.each do |user|
      JobVacancy::App.deliver(:notification, :offer_notification_email, self, user.email)
    end
  end
end
