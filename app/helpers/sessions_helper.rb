module SessionsHelper

  def sign_in(user)
    cookies.permanent[:token] = user.token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_token(cookies[:token])
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
