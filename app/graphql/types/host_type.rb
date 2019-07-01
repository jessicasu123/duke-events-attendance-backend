module Types
	class HostType < Types::BaseObject
		field :id, ID, null:false
		field :events, [EventType], null:false 
	end
end
