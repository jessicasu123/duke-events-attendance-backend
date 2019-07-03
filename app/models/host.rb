class Host < ApplicationRecord
	has_many :subscriptions, as: :subscribable

	has_many :events, through: :subscriptions, source: :subscriber, source_type: 'Event'

	#has_many :subscribers, through: :subscriptions, source: :subscriber, source_type: 'Event'
	#has_many :events, through: :subscriptions, source: :subscriber, source_type: 'Event'
end
