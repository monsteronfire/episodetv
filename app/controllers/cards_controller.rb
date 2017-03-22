class CardsController < ApplicationController
  before_action :authenticate_user!
  #before_action :subscribed?

  def update
    customer = remote_customer
    subscription = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
    subscription.source =  params[:stripeToken]
    subscription.save

    current_user.update(
      card_last_4: remote_customer_card.last4,
      card_exp_month: remote_customer_card.exp_month,
      card_exp_year: remote_customer_card.exp_year,
      card_brand: remote_customer_card.brand
    )

    redirect_to edit_card_path
  end

  private

  def remote_customer
    Stripe::Customer.retrieve(current_user.stripe_id)
  end

  def remote_customer_card
    remote_customer.sources.data[0]
  end

  def card_id
    remote_customer_card.id
  end

end
