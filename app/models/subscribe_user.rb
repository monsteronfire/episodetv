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
        Stripe::Customer.create( email: params[:stripeEmail] )
      end
    end
  end

  def create_remote_subscription
    @subscription ||= remote_customer.subscriptions.create(
      source: params[:stripeToken],
      plan: plan_id
    )
  end

  def update_user_subscription_info
    user.update(
      stripe_id: remote_customer.id,
      stripe_subscription_id: subscription.id,
      card_last4: remote_customer.card_last_4,
      #card_exp_month: params[:card_exp_month],
      #card_exp_year: params[:card_year_month],
      #card_brand: params[:card_brand]
    )
  end
end
