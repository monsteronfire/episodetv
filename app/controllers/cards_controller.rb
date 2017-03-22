class CardsController < ApplicationController
  before_action :authenticate_user!
  #before_action :subscribed?

  def update
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    subscription = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
    subscription.source =  params[:stripeToken]
    subscription.save

    current_user.update(
      card_last_4: remote_customer_card.last4,
      card_exp_month: remote_customer_card.exp_month,
      card_exp_year: remote_customer_card.exp_year,
      card_brand: remote_customer_card.brand
    )

    redirect_to edit_user_registration_path
  end
end
