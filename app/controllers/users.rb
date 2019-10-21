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
      flash[:success] = 'User created'
      redirect '/'
    else
      flash.now[:error] = (@user.errors.messages.map { |_key, value| value }).uniq.join(', ')
      render 'users/new'
    end
  end
end
