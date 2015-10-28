class UsersController < ApplicationController
  before_filter :find_token, only: :confirm
  load_and_authorize_resource


  # before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  # before_filter :correct_user,   only: [:edit, :update]
  # before_filter :admin_user,     only: :destroy
  # before_filter :info_signed_in_user, only: [:new, :create]




  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.signup_confirmation(@user).deliver
      flash[:warning] = 'To complete registration, please check you email'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = 'Profile updated!'
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = 'User deleted!'
    redirect_to users_url
  end

  def confirm
    if @user
      if @user.state == 'inactive'
        @user.activate!
        @user.roles=(['regular'])
        @user.save!
        sign_in @user
        flash[:success] = "Account confirmed. Welcome #{@user.name}!"
        redirect_to root_url
      else
        sign_out if signed_in?
        flash[:warning] = 'Account is already activated. Please sign in instead.'
        redirect_to signin_path
      end
    else
      flash[:danger] = 'Invalid confirmation token'
      sign_out if signed_in?
      redirect_to root_url
    end
  end

  def find_token
    @user = User.find_by_token(params[:id])
  end

  private
end
