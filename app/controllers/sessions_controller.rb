class SessionsController < ApplicationController

  def new
  end

  def create

    # 18/04/2016 ADD OMNIAUTH
    if request.env['omniauth.auth']
      user = User.create_with_omniauth request.env['omniauth.auth']
      log_in user
      remember user
      redirect_to user

    else
      
      user = User.find_by email: params[:session][:email].downcase

      if user && user.authenticate(params[:session][:password])
        if user.activated?
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          redirect_back_or user
        else
          message = "Account not activated. "
          message += "Check your email for the activation link."
          flash[:warning] = message
          redirect_to root_url
        end
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
