require 'net/http'
require 'json'
require 'uri'
class EventsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index 
	@filterrific = initialize_filterrific(
	      Event,
	      params[:filterrific],
	      persistence_id: "shared_key",
	      default_filter_params: {},
	      available_filters: [:search_query, :with_eventid, :with_title],
	      sanitize_params: true,
    ) || return
		#@events = @filterrific.find.page(params[:page])
		@test = get_my_events(current_user.netid)
		@events = @test

		respond_to do |format|
	      format.html
	      format.js
	    end

	    rescue ActiveRecord::RecordNotFound => e
		    # There is an issue with the persisted param_set. Reset it.
		    puts "Had to reset filterrific params: #{e.message}"
		    redirect_to(reset_filterrific_url(format: :html)) && return

		#@events = Event.all 
	end 

	def edit
	end

	def openEvent
		@event = Event.find_by_eventid(params[:id])
		@event.status = "active"
		@event.checkintype = params[:checkintype]
		@event.save
	end

	def edit
		@event = Event.find(params[:id])
	end


	def show 
		@event = Event.find(params[:id])
		respond_to do |format|
			format.html
	      	format.js
			format.csv { send_data @event.to_csv, filename: "#{@event.title}.csv" }
		end
	end

	def new 
		@event = Event.new 
	end

	def create
		val = eval( "#{ params[:event_host_subscription] }")
		@event = Event.find_by_eventid($events_hash[val["title"]])
		@host = Host.find_by_hostid(val["subscribable_id"])

		if @event.blank? #doesn't exist
			@event = Event.new(:eventid => $events_hash[val["title"]], :title => val["title"], :status => "inactive", :checkintype => "unspecified")
		else
			#throw error
		end

		if @host.blank?
			@host = Host.new(:hostid => val["subscribable_id"])
		else
			#throw error
		end

		if !@event.hosts.pluck(:hostid).include?(@host.hostid)
			@event.save 
			@host.save
			@subscription = @event.subscriptions.new(subscribable: @host)
			@subscription.save
		end

		redirect_to @event

	end



	def destroy
  		@event = Event.find(params[:id])
  		@event.destroy
  		redirect_to events_path
	end

	private
	  def get_my_events(netID)
		#search both JSON feed and our own database (for future events)
		#THIS IS WHERE WE CAN MAYBE INTEGRATE SHIB? BEFORE THIS? 
		@myNetID = netID #currently hard coded, in the future this will be shib integrated
		#index is what is called when we list the events from @events...
		#instead of showing all the events in our database, we will now
		#show all the events in Duke Calendar associated with the NetID
		#per the global variable $myNetID
		url = "https://calendar.duke.edu/events/index.json?&future_days=90&feed_type=simple&local=true"
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		request = Net::HTTP::Get.new(uri.request_uri)
		response = http.request(request).body
		doc = JSON.parse(response)
		@events_array = doc["events"]
		@my_events = Array.new
		#$events_hash = Hash.new
		puts @myNetID
		@events_array.each do |event| 
			if event["submitted_by"] != nil
				if event["submitted_by"][0].strip() == @myNetID
					@my_events << event #this is a different type than line 152...
					# @event = Event.find_by_eventid(event["title"])
					# #@host = Host.find_by_hostid(val["subscribable_id"])

					# if @event.blank? #doesn't exist
					# 	@event = Event.new(:eventid => event["id"], :title => event["summary"], :status => "inactive", :checkintype => "unspecified")
					# else
					# 	#throw error
					# end

					# if @host.blank?
					# 	@host = Host.new(:hostid => $myNetID)
					# else
					# 	#throw error
					# end

					# if !@event.hosts.pluck(:hostid).include?(@host.hostid)
					# 	@event.save 
					# 	@host.save
					# 	@subscription = @event.subscriptions.new(subscribable: @host)
					# 	@subscription.save
					# end

					#$my_events << @event
				end
			end
		end

		@database_events = Event.all
		@database_events.each do |event|
			if event.hosts.pluck(:hostid).include?(@myNetID)
				puts event
				@my_events << { "id" => event.eventid, "summary" => event.title } #this is a different type than line 120...
			end
		end

		@my_events
	end

end
