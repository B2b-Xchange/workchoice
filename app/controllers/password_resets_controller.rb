class PasswordResetsController < ApplicationController

  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
  end

  def create

    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t(:controller_resets_create_flash_info)
      redirect_to root_url
    else
      flash.now[:danger] = t(:controller_resets_create_flash_danger)
      render 'new'
    end
    
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t(:controller_resets_update_empty)
      render 'edit'
    elsif @user.update_attributes user_params
      log_in @user
      flash[:success] = t(:controller_resets_update_flash_success)
      redirect_to @user
    else
      render 'edit'
    end
  end
                                                    

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # before filters
  
  def get_user
    @user = User.find_by email: params[:email]
  end

  # confirms a valid user
  def valid_user
    unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  # check expiration of reset token
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t(:controller_resets_expired_flash_danger)
      redirect_to new_password_reset_url
    end
  end
  
end
