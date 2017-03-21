class SubscribeUser
  attr_reader :user, :plan_id, :params
  attr_accessor :subscription

  def initialize(user, plan_id, params)
    @user = user
    @plan_id = plan_id
    @params = params
  end

  def call
    create_remote_subscription
    update_user_subscription_info
  end

  private

  def remote_customer
    @remote_customer ||= begin
      if user.stripe_id?
        Stripe::Customer.retrieve(user.stripe_id)
      else
        Stripe::Customer.create(
          email: params[:stripeEmail],
          card: params[:stripeToken]
        )
      end
    end
  end

  def create_remote_subscription
    @subscription ||= remote_customer.subscriptions.create(
      plan: plan_id
    )
  end

  def remote_customer_card
    remote_customer.sources.data[0]
  end

  def update_user_subscription_info
    #raise remote_customer
    user.update(
      stripe_id: remote_customer.id,
      stripe_subscription_id: subscription.id,
      card_last_4: remote_customer_card.last4,
      card_exp_month: remote_customer_card.exp_month,
      card_exp_year: remote_customer_card.exp_year,
      card_brand: remote_customer_card.brand
    )
  end
end
