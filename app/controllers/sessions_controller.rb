class SessionsController < ApplicationController

  def new
  end

  def create

    # 18/04/2016 ADDED OMNIAUTH
    if request.env['omniauth.auth']
      user = User.create_with_omniauth request.env['omniauth.auth']
      log_in user
      remember user
      redirect_to user
    else
      
      user = User.find_by email: params[:session][:email].downcase

      if user && user.authenticate(params[:session][:password])
        # log the user in and route him to his user's show page
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user
      else
        # Display an error message
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end
    
  end

  def destroy

    log_out if logged_in?
    redirect_to root_url
  end
  
end
