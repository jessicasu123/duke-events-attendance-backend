module Types
	class EventType < Types::BaseObject
		field :id, ID, null:false
		field :eventid, String, null:false
		field :hosts, [HostType], null:false 
		field :attendees, [AttendeeType], null:false
		field :title, String, null:false
		field :status, String, null:false
		field :checkintype, String, null:false
		field :hostlat, String, null:false
		field :hostlong, String, null:false
	end
end
