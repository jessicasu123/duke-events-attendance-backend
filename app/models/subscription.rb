class Subscription < ApplicationRecord
	belongs_to :subscriber, :polymorphic => true
	belongs_to :subscribable, :polymorphic => true

	validates :subscribable_type, presence: true
	validates :subscribable_id, presence: true

end
