module Mutations
	class CheckOut < GraphQL::Schema::Mutation
  		description "record check out time of attendee based on when they leave the geofence"

  		argument :eventid, String, required: true
  		#argument :duid, String, required: true #to be removed]
  		argument :time, String, required: true

  		type Types::HostType

		def resolve(eventid:nil, time:nil) #duid to be removed
		    eventid = eventid.strip()
			@event = Event.find_by_eventid(eventid)
			@attendee = Attendee.find_by_duid($uniqueID) #to be replaced by line below

			if @event.blank?
				err = "Event not available for check-out" 
				GraphQL::ExecutionError.new(err)
			else
				if @attendee.blank?
					err = "Attendee never checked in" 
					GraphQL::ExecutionError.new(err)
				else
					@subscription = @event.subscriptions.find_by( subscriber_id: @event.id, subscribable_id: @attendee.id, subscribable_type: "Attendee")
					
					@subscription.checkout_time = time

					@subscription.save
					
					puts @subscription.checkout_time
				end
			end

		end
	end
end