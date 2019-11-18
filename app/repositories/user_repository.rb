class UserRepository < BaseRepository
  self.table_name = :users
  self.model_class = 'User'

  def find_by_email(email)
    row = dataset.first(email: email)
    load_object(row) unless row.nil?
  end

  def find_by_matching_tags(tags)
    regex = Regexp.new("(,|^)(#{tags.join('|')})(,|$)")
    load_collection dataset.where(prefered_tags: regex)
  end

  protected

  def changeset(user)
    {
      name: user.name,
      crypted_password: user.crypted_password,
      email: user.email,
      short_bio: user.short_bio,
      login_failed_attempts: user.login_failed_attempts,
      last_lock_date: user.last_lock_date,
      prefered_tags: user.prefered_tags
    }
  end

  def insert(user)
    raise StandardError, 'User email must be unique' unless DB[self.class.table_name][{ email: user.email }].nil?

    super(user)
  end
end
