class Event < ApplicationRecord
	has_many :subscriptions, as: :subscriber
	
	has_many :attendees, through: :subscriptions, source: :subscribable, dependent: :destroy, source_type: 'Attendee'
	has_many :hosts, through: :subscriptions, source: :subscribable, dependent: :destroy, source_type: 'Host'
end
