module Mutations
	class CheckOut < GraphQL::Schema::Mutation
  		description "record check out time of attendee based on when they leave the geofence"

  		argument :eventid, String, required: true
  		argument :duid, String, required: true #to be removed

  		type Types::HostType

		def resolve(eventid:nil,duid:nil) #duid to be removed
		    eventid = eventid.strip()
			@event = Event.find_by_eventid(eventid)
			@attendee = Attendee.find_by_duid(duid) #to be replaced by line below

			if @event.blank?
				err = "Event not available for check-out" 
				GraphQL::ExecutionError.new(err)
			else
				if @attendee.blank?
					err = "Attendee never checked in" 
					GraphQL::ExecutionError.new(err)
				else
					@subscription = @event.subscriptions.find_by( subscriber_id: @event.id, subscribable_id: @attendee.id, subscribable_type: "Attendee")
					@subscription.checkout_time = "hack"
					@subscription.save
					@subscription.checkout_time = @subscription.updated_at
					#now the checkout column is essentially the same as the time the
					#subscription was updated... is it even necessary to have a check-out
					#column? will there be a case in which the updated at time != the
					#check-out time?
					#another option is having the iOS app send the check-out time as a parameter
					puts @subscription.checkout_time
					@subscription.save
					puts @subscription.id #when i remove this i get an error... 
				end
			end

		end
	end
end