JobVacancy::App.helpers do
  attr_writer :current_user

  def current_user
    @current_user ||= UserRepository.new.find(session[:current_user])
  end

  def sign_in(user)
    session[:current_user] = user.id
    self.current_user = user
  end

  def sign_out
    session.delete(:current_user)
  end

  def signed_in?
    !current_user.nil?
  rescue Sequel::NoMatchingRow
    false
  end

  def session_create_path
    '/sessions/create' + param_redirect_to
  end

  def register_path
    '/register' + param_redirect_to
  end
end
