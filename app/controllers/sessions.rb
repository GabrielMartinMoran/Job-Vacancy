JobVacancy::App.controllers :sessions do
  get :login, map: '/login' do
    @user = User.new
    render 'sessions/new'
  end

  post :create do
    email = params[:user][:email]
    password = params[:user][:password]

    user_by_email = UserRepository.new.find_by_email(email)
    if !user_by_email.nil? && user_by_email.locked?
      flash[:error] = 'This account is locked'
      return redirect '/login'
    end

    gate_keeper = GateKeeper.new.authenticate(email, password)

    gate_keeper.when_succeed do |user|
      @user = user
      sign_in @user
      return redirect params[:redirect_to] unless params[:redirect_to].nil?

      redirect '/'
    end

    gate_keeper.when_failed do
      if !user_by_email.nil? && !user_by_email.locked?
        user_by_email.add_login_failed_attempt
        UserRepository.new.save(user_by_email)
      end
      @user = User.new
      flash[:error] = 'Invalid credentials'
      redirect '/login'
    end
  end

  get :destroy, map: '/logout' do
    sign_out
    redirect '/'
  end
end
