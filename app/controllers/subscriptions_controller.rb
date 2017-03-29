class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  before_action :redirect_to_sign_up, only: [:new]

  def show
  end

  def new
  end

  def create
    if SubscribeUser.new(current_user, 'monthly-plan', params).call
      SubscriptionMailer.subscription_success_email(current_user).deliver_now
      redirect_to root_path, notice: 'You have successfully subscribed.'
    else
      render :new, notice: 'Unable to subscribe you.'
    end
  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    #customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete(at_period_end: true)
    customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    SubscriptionMailer.cancel_subscription_email(current_user).deliver_now

    current_user.update(
      stripe_subscription_id: nil,
      stripe_card_id: nil
    )

    redirect_to root_path, notice: 'Your subscription has been cancelled'
  end

  private

  def redirect_to_sign_up
    if !user_signed_in?
      session['user_return_to'] = new_subscription_path
      redirect_to  new_user_registration_path
    end
  end
end
