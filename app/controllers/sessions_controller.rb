class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.state == 'inactive'
        flash[:danger] = "Your account isn't confirmed. Please check your email."
        redirect_to root_url
      else
        sign_in user
        redirect_back_or root_url
      end
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
