module Types
	class EventType < Types::BaseObject
		field :id, ID, null:false
		field :eventid, String, null:false
		field :hosts, [HostType], null:false 
		field :attendees, [AttendeeType], null:false
	end
end
