module Types
  class QueryType < BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :all_attendees, [AttendeeType], null: false do
      description "Returns all attendees for a particular event by event id"
      argument :id, ID, required: true
    end


    def all_attendees(id:)
      @event = Event.find_by_eventid(id)
      @event.attendees
    end

    field :host_events, [EventType], null: false do
      description "Returns all events for a particular host by host id"
      argument :id, ID, required: true
    end

    def host_events(id:)
      @host = Host.find_by_hostid(id)
      @host.events
    end

    field :all_hosts, [HostType], null: false do 
      description "Returns all the hosts for a particular event"
      argument :id, ID, required: true 
    end 

    def all_hosts(id:)
      @event = Event.find_by_eventid(id)
      @event.hosts
    end 

    field :attendee_events, [EventType], null: false do 
      description "Returns all events for a particular attendee by duid"
      argument :id, ID, required: true 
    end 

    def attendee_events(id:)
      @attendee = Attendee.find_by_duid(id)
      @attendee.events 
    end 


    field :attendee_events, [EventType], null: false do
      description "Returns all events for a particular attendee by duid"
      argument :id, ID, required: true
    end

    def attendee_events(id:)
      @attendee = Attendee.find_by_duid(id)
      @attendee.events
    end



  end
end
