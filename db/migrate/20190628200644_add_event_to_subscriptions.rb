class AddEventToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :subscriptions, :event, foreign_key: true
  end
end
