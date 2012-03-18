class Rstatus

  get "/login" do
    if logged_in?
      redirect '/'
    else
      haml :"login/login"
    end
  end

  # We have a bit of an interesting feature with the POST to /login.
  # Normally, this would just log you in, but for super ease of use, we've
  # decided to make it sign you up if you don't have an account yet, and log
  # you in if you do. Therefore, we try to fetch your user from the DB, and
  # check if you're there, which is the first half of the `if`. The `else`
  # is your run-of-the-mill login procedure.
  post "/login" do
    u = User.first :username => params[:username]
    if u.nil?
      # Grab the domain for this author from the request url
      params[:domain] = url("/")[/\:\/\/(.*?)\/$/, 1]

      author = Author.new params

      @user = User.new params.merge({:author => author})
      if @user.valid?
        if params[:password].length > 0
          author.save
          @user.save
          session[:user_id] = @user.id
          flash[:notice] = "Thanks for signing up!"
          redirect "/"
        else
          @user.errors.add(:password, "can't be empty")
        end
      end
      haml :"login/login"
    else
      if user = User.authenticate(params[:username], params[:password])
        session[:user_id] = user.id
        session[:remember_me] = (params[:remember_me])
        flash[:notice] = "Login successful."
        redirect "/"
      end
      flash[:error] = "The username exists; the password you entered was incorrect. If you are trying to create a new account, please choose a different username."
      redirect "/login"
    end
  end

  get "/logout" do
    # XXX: I'm pretty sure we don't need this logged_in? call. Too bad this
    # commit is only documentation. :)
    if logged_in?
      session[:user_id] = nil
      flash[:notice] = "You've been logged out."
    end
    redirect '/'
  end

end
