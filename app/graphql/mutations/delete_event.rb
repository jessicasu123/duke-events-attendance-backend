module Mutations 
	class DeleteEvent < GraphQL::Schema::Mutation 
		description "Delete event, along with associated hosts & attendees"

		argument :eventid, String, required: true

		type Types::EventType

		def resolve(eventid: nil)
			@event = Event.find_by_eventid(eventid)
			@event.destroy

			
		end 

	end
end 