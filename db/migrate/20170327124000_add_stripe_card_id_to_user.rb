class AddStripeCardIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_card_id, :string
  end
end
