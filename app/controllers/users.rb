JobVacancy::App.controllers :users do
  get :new, map: '/register' do
    @user = User.new
    render 'users/new'
  end

  post :create do
    password_confirmation = params[:user][:password_confirmation]
    params[:user].reject! { |k, _| k == 'password_confirmation' }

    @user = User.new(params[:user])

    could_create_user = @user.validate_password(params[:user][:password], password_confirmation)

    begin
      could_create_user &&= UserRepository.new.save(@user)
    rescue StandardError
      flash.now[:error] = 'An user with same email is already registered'
      return render 'users/new'
    end

    if could_create_user
      sign_in @user
      flash[:success] = 'User created'
      return redirect params[:redirect_to] unless params[:redirect_to].nil?

      redirect '/'
    else
      flash.now[:error] = (@user.errors.messages.map { |_key, value| value }).uniq.join(', ')
      render 'users/new'
    end
  end

  get :profile_update, map: '/profile_update' do
    @user = current_user
    render 'users/profile_update'
  end

  put :update do
    @user = User.new(id: current_user.id, email: current_user.email,
                     crypted_password: current_user.crypted_password, name: params[:user][:name],
                     short_bio: params[:user][:short_bio], prefered_tags: params[:user][:prefered_tags])

    password_error = false
    if params[:user][:password] + params[:user][:password_confirmation] != ''
      if @user.validate_password(params[:user][:password], params[:user][:password_confirmation])
        @user.password = params[:user][:password]
      else
        password_error = true
      end
    end

    return redirect '/' if !password_error && UserRepository.new.save(@user)

    flash.now[:error] = (@user.errors.messages.map { |_key, value| value }).uniq.join(', ')
    render 'users/profile_update'
  end
end
