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



  end
end
