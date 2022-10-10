JobVacancy::App.controllers :users do
  get :new, map: '/register' do
    @user = User.new
    render 'users/new'
  end

  post :create do
    password_confirmation = params[:user][:password_confirmation]
    params[:user].reject! { |k, _| k == 'password_confirmation' }

    begin
      @user = User.new(params[:user])

      if params[:user][:password] == password_confirmation
        if UserRepository.new.save(@user)
          flash[:success] = 'User created'
          redirect '/'
        else
          flash.now[:error] = 'All fields are mandatory'
          render 'users/new'
        end
      else
        flash.now[:error] = 'Passwords do not match'
        render 'users/new'
      end
    rescue PasswordError => e
      flash.now[:error] = e.message.to_s
      @user = User.new
      render 'users/new'
    end
  end
end
