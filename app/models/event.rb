class Event < ApplicationRecord
	has_many :subscriptions
	has_many :attendees, through: :subscriptions, source: :subscribable, source_type: 'Attendee'
	has_many :hosts, through: :subscriptions, source: :subscribable, source_type: 'Host'
end
