class CheckIn < ApplicationRecord
	belongs_to :checkinable, :polymorphic => true
end
