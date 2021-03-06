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
      puts $netID
      @host = Host.find_by_hostid($netID)
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

    field :get_my_info, [String], null: false do
      description "Returns user info by access token"
    end


    def get_my_info()
      [Idmws.getCardNumber($uniqueID)[0], Idmws.getName($uniqueID), $netID, $uniqueID]
    end


    field :get_event, EventType, null: false do
      description "Returns event info by id"
      argument :eventid, ID, required: true
    end

    def get_event(eventid:nil)
      Event.find_by_eventid(eventid)
    end

    field :get_active_events, [EventType], null: false do 
      description "Returns all active events" 
    end 

    def get_active_events() 
      active_array = Array.new  
      @events = Event.all
      @events.each do |event| 
        if event.status == "active" 
          active_array.push(event)
        end 
      end 
      
      active_array

    end


    # field :get_duke_card_number, String, null: false do
    #   description "Returns duke card number by duke unique id"
    # end

    # def get_duke_card_number()
    #   Idmws.getCardNumber($uniqueID)[0]
    # end

    # field :get_myname, String, null: false do
    #   description "Returns name by user's duke unique id from headers"
    # end

    # def get_myname()
    #   Idmws.getName($uniqueID)
    # end

    # field :get_name, String, null: false do
    #   description "Returns name by duke unique id"
    #   argument :id, ID, required: true
    # end

    # def get_name(id:)
    #   Idmws.getName(id, "card")
    # end

    # field :get_netid, String, null: false do
    #   description "Returns netid by duke unique id"
    # end

    # def get_netid()
    #   $netID
    # end

    field :get_info, [String], null: false do
      description "Returns name and check in time by duke unique id"
      argument :attendeeid, ID, required: true
      argument :eventid, ID, required: true
    end

    def get_info(attendeeid:, eventid:)
    

      @event = Event.find_by_eventid(eventid)

      @event.subscriptions.each do |subscription|
        if subscription.subscribable_type == 'Attendee'
          puts "here"
          if Attendee.find(subscription.subscribable_id).duid = attendeeid
            @time = subscription.created_at.strftime("%I:%M %p")
            puts @time
          end
        end
      end
      [@time, Idmws.getName(attendeeid)]
    end



    # field :get_duid, String, null: false do 
    #   description "Returns duke unique id"
    # end 

    # def get_duid() 
    #   $uniqueID
    # end 

    # field :get_check_in_time, String, null: false do
    #   description "Returns check in time by card number"
    #   argument :attendeeid, ID, required: true
    #   argument :eventid, ID, required: true
    # end

    # def get_check_in_time(attendeeid:, eventid:)
    #   @event = Event.find_by_eventid(eventid)
    #   @attendee = @event.attendees.find_by_duid(attendeeid)
    #   @time = @attendee.created_at.strftime("%I:%M %p")
    #   @time
    # end

  end
end
