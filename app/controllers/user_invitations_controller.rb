class UserInvitationsController < ApplicationController

  def new
  end

  def create
    if User.exists?(email: params[:user_invitation][:email])
      flash.now[:danger] = 'This user already exist in the application'
      render 'new'
    else
      @password = SecureRandom.urlsafe_base64
      @user = User.new(name: 'New User',
                    email: params[:user_invitation][:email],
                    password: @password,
                    password_confirmation: @password)

      @user.roles=(['regular'])
      @user.house_id = current_user.house_id
      @user.activate!
      flash[:success] = "Invitation sent at #{params[:user_invitation][:email]}!"
      @user.send_invitation(@password)
      redirect_to root_url
    end
  end
end
