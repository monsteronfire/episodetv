class SubscriptionMailer < ApplicationMailer
  def subscription_success_email(user)
    @user = user
    @url = "http://localhost:3000/users/sign_in"
    mail(to: @user.email, subject: "Your have successfully subscribed to EpisodesTV")
  end
end
