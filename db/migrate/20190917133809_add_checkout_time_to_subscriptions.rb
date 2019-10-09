class AddCheckoutTimeToSubscriptions < ActiveRecord::Migration[5.2]
  def change
  	add_column :subscriptions, :checkout_time, :string
  end
end
