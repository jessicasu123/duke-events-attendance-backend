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
    end

    def host_events()
      @host = Host.find_by_hostid($netid)
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

    field :get_duke_card_number, String, null: false do
      description "Returns duke card number by duke unique id"
    end

    def get_duke_card_number()
      Idmws.getCardNumber($uniqueID)[0]
    end

    field :get_myname, String, null: false do
      description "Returns name by user's duke unique id from headers"
    end

    def get_myname()
      Idmws.getName($uniqueID, "duid")
    end

    field :get_name, String, null: false do
      description "Returns name by duke unique id"
      argument :id, ID, required: true
    end

    def get_name(id:)
      Idmws.getName(id, "card")
    end

    # field :get_netid, String, null: false do
    #   description "Returns netid by duke unique id"
    # end

    # def get_netid()
    #   $netID
    # end

    field :get_check_in_time, String, null: false do
      description "Returns check in time by card number"
      argument :attendeeid, ID, required: true
      argument :eventid, ID, required: true
    end

    def get_check_in_time(attendeeid:, eventid:)
      @event = Event.find_by_eventid(eventid)
      @attendee = @event.attendees.find_by_duid(attendeeid)
      @time = @attendee.created_at.strftime("%I:%M %p")
      @time
    end

  end
end
