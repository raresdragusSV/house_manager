class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:password_reset][:email])
    if user
      user.send_password_reset
    end
    redirect_to root_url
    flash[:warning] = 'Email sent with password reset instructions.'
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path
      flash[:danger] = 'Password reset has expired.'
    elsif @user.update_attributes(params[:user])
      redirect_to root_url
      flash[:warning] = 'Password has been reset!'
    else
      render :edit
    end
  end
end
