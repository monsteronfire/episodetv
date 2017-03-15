class UserMailer < ActionMailer::Base
  @user = User.find(user_id)

  mail(
    to: @user.email,
    subject: "Welcome",
  ) do |format|
    format.text
    format.html
  end
end
