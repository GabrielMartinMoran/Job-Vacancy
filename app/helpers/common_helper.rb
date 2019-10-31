JobVacancy::App.helpers do
  def param_redirect_to
    return "?redirect_to=#{params[:redirect_to]}" unless params[:redirect_to].nil?

    ''
  end
end
