module Mutations
	class AttendeeCheckIn < GraphQL::Schema::Mutation
		description "Check in as attendee"

		argument :eventid, String, required: true
		argument :duid, String, required: true

		type Types::HostType

		def resolve(eventid:nil, duid:nil)
			#add validation code
			@event = Event.find_by_eventid(eventid)
			@attendee = Attendee.find_by_duid(duid)

			#throw error if event isn't available for check-in yet
			if @event.blank?
				err = "Event not available for check-in"
				GraphQL::ExecutionError.new(err)
			else
				if @attendee.blank?
					@attendee = Attendee.create(:duid => duid)
				else
					#throw error
				end

				if !@event.attendees.pluck(:duid).include?(@attendee.duid) 
					xml = Transact.createDukeCardXML(duid)
					if Transact.verify(xml) == "0" 
						subscription = @event.subscriptions.create(subscribable: @attendee)
					else
						GraphQL::ExecutionError.new("Invalid Card Number")
					end
				end
			end

		end

	end
end