class WelcomeEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    SubscriptionMailer.subscription_success_email(user).deliver
  end
end
