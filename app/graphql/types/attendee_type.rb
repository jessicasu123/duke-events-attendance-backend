module Types
	class AttendeeType < Types::BaseObject
		field :id, ID, null:false
		field :duid, String, null:false
		field :events, [EventType], null:false 
		field :name, String, null:false
	end
end
