class UpdateCard
  attr_reader :user, :params
  attr_accessor :subscription

  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    get_remote_subscription.source = params[:stripeToken]
    get_remote_subscription.save
    update_card
  end

  private

  def remote_customer
    Stripe::Customer.retrieve(user.stripe_id)
  end

  def get_remote_subscription
    @subscription ||= remote_customer.subscriptions.retrieve(user.stripe_subscription_id)
  end

  def remote_customer_card
    remote_customer.sources.data[0]
  end

  def update_card
    user.update(
      card_last_4: remote_customer_card.last4,
      card_exp_month: remote_customer_card.exp_month,
      card_exp_year: remote_customer_card.exp_year,
      card_brand: remote_customer_card.brand
    )
  end
end
