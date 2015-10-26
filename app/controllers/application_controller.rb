class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = 'Access denied!'
    redirect_to root_url
  end
end
