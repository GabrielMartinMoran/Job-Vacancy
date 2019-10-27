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

  def create_path
    url = '/sessions/create'
    url += "?redirect_to=#{params[:redirect_to]}" unless params[:redirect_to].nil?

    url
  end
end
