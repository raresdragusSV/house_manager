class UserMailer < ActionMailer::Base
  default from: "rares.dragus@softvision.ro"

  def signup_confirmation(user)
    @user = user
    mail(to: "#{@user.email}", subject: 'Confirmation Account')
  end

  def password_reset(user)
    @user = user
    mail(to: "#{@user.email}>", subject: 'Password Reset')
  end

  def invitation(user, password)
    @user = user
    @password = password
    mail(to: "#{@user.email}>", subject: 'Home Manager Project Invitation')
  end
end
