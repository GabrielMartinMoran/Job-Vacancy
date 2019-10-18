class UserRepository < BaseRepository
  self.table_name = :users
  self.model_class = 'User'

  def find_by_email(email)
    row = dataset.first(email: email)
    load_object(row) unless row.nil?
  end

  protected

  def changeset(user)
    {
      name: user.name,
      crypted_password: user.crypted_password,
      email: user.email,
      short_bio: user.short_bio
    }
  end

  def insert(a_record)
    super(a_record)
  rescue Sequel::UniqueConstraintViolation
    raise StandardError, 'User email must be unique'
  end
end
