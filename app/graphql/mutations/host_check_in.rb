module Mutations
	class HostCheckIn < GraphQL::Schema::Mutation
		description "Check in as host"

		argument :eventid, String, required: true
		argument :hostid, String, required: true

		type Types::HostType

		def resolve(eventid:nil, hostid:nil)
			#add validation code
			#if event already exists, then add that host to the event
			@event = Event.find_by_eventid(eventid)
			@host = Host.find_by_hostid(hostid)

			if @event.blank? #doesn't exist
				@event = Event.create(:eventid => eventid)
			else
				#throw error
			end

			if @host.blank?
				@host = Host.create(:hostid => hostid)
			else
				#throw error
			end

			if !@event.hosts.pluck(:hostid).include?(@host.hostid) 
				subscription = @event.subscriptions.create(subscribable: @host)
			end

		end

	end
end