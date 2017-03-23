class CardsController < ApplicationController
  before_action :authenticate_user!
  #before_action :subscribed?

  def update
    UpdateCard.new(current_user, params).call
    redirect_to edit_card_path
  end

end
