class AddIdToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :subscriber_id, :integer
    add_column :subscriptions, :subscriber_type, :string
  end
end
