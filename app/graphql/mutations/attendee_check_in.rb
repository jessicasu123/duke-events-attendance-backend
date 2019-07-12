module Mutations
	class AttendeeCheckIn < GraphQL::Schema::Mutation
		description "Check in as attendee"

		argument :eventid, String, required: true
		#argument :duid, String, required: true

		type Types::HostType

		
		#@cardnumber = Idmws.getCardNumber($uniqueID)
		#puts @cardnumber

		#remove duid param
		def resolve(eventid:nil)
			
			#puts request.headers.inspect

			# duid = request.headers['duid']
			# duid to idms web services
			# get attributes (DukeCardNumber, First Name, LastName)

			
			#add validation code
			@event = Event.find_by_eventid(eventid)
			@cardnumber = Idmws.getCardNumber($uniqueID)[0]
			puts "CARD NUMBER: #{@cardnumber}"
			@attendee = Attendee.find_by_duid(@cardnumber)
			# @cardnumber = Idmws.get_card_number($uniqueID)
			# puts @cardnumber

			#throw error if event isn't available for check-in yet
			if @event.blank?
				err = "Event not available for check-in" 
				GraphQL::ExecutionError.new(err)
			else
				if @attendee.blank?
					@attendee = Attendee.create(:duid => @cardnumber)
				else
					#throw error
				end

				if !@event.attendees.pluck(:duid).include?(@attendee.duid) 

					xml = Transact.createDukeCardXML(@cardnumber)
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