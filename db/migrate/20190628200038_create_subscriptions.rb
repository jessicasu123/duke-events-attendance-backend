class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer :subscribable_id
      t.string :subscribable_type

      t.integer :subscriber_id
      t.string :subscriber_type

      t.timestamps
    end
  end
end
