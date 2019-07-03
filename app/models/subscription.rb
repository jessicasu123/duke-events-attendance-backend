class Subscription < ApplicationRecord
	belongs_to :subscriber, :polymorphic => true
	belongs_to :subscribable, :polymorphic => true
end
