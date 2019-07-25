module Mutations
	class CloseEvent < GraphQL::Schema::Mutation
  		description "close event to check in"

  		argument :eventid, String, required: true

  		type Types::EventType

		def resolve(eventid:nil)
		    event = Event.find_by_eventid(eventid)
		    event.status = "inactive"
			event.save
			event
		end
	end
end