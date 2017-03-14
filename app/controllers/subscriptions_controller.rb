class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  before_action :redirect_to_sign_up, only: [:new]

  def show
  end

  def new
  end

  def create
    # Amount in cents
    @amount = 500

    customer = if current_user.stripe_id?
                 Stripe::Customer.retrieve(current_user.stripe_id)
               else
                 Stripe::Customer.create( email: params[:stripeEmail] )
               end

    subscription = customer.subscriptions.create(
      source: params[:stripeToken],
      plan: '1'
    )

    current_user.update(
      stripe_id: customer.id,
      stripe_subscription_id: subscription.id
    )

    redirect_to root_path
  end

  def destroy
  end

  private

  def redirect_to_sign_up
    if !user_signed_in?
      session['user_return_to'] = new_subscription_path
      redirect_to  new_user_registration_path
    end
  end
end
