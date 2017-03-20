class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  before_action :redirect_to_sign_up, only: [:new]

  def show
  end

  def new
  end

  def create
    if SubscribeUser.new(current_user, '1', params).call
      redirect_to root_path, notice: 'You have successfully subscribed.'
    else
      render :new, notice: 'unable to subscribe you.'
    end
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
