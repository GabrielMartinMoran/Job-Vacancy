# Helper methods defined here can be accessed in any controller or view in the application

JobVacancy::App.helpers do
  def user_create_path
    '/users/create' + param_redirect_to
  end
end
