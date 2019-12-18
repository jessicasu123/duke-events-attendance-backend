module Mutations
	class OpenEvent < GraphQL::Schema::Mutation
  		description "open event for check in with type"

  		argument :eventid, String, required: true
  		argument :checkintype, String, required: true
  		argument :hostlat, String, required: true 
  		argument :hostlong, String, required: true 

  		type Types::EventType

		def resolve(eventid:nil, checkintype:nil, hostlat:nil, hostlong:nil)
		    event = Event.find_by_eventid(eventid)
		    event.status = "active"
			event.checkintype = checkintype
			event.hostlat = hostlat 
			event.hostlong = hostlong
			event.save
			event
		end
	end
end