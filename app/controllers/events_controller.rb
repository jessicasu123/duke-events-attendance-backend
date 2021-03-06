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
		@database_events = Event.all
		@events = Array.new()
		@database_events.each do |event|
			if event.hosts.pluck(:hostid).include?(current_user.netid)
				@events << event
			end
		end


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
		@event.hostlat = params[:hostlat]
		@event.hostlong = params[:hostlong]
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
			@event = Event.new(:eventid => $events_hash[val["title"]], :title => val["title"], :status => "inactive", :checkintype => "unspecified", :hostlat => "0.0", :hostlong => "0.0")
		else
			#throw error
		end

		if @host.blank?
			@host = Host.new(:hostid => val["subscribable_id"], :name => Idmws.getNameFromNetID(val["subscribable_id"]))
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

	def addHost
		val = eval( "#{ params[:event_host_subscription] }")
		puts val["id"]
		@event = Event.find_by_id(val["id"])
		@host = Host.find_by_hostid(val["subscribable_id"]) 

		if @host.blank?
			@host = Host.new(:hostid => val["subscribable_id"],:name => Idmws.getNameFromNetID(val["subscribable_id"]))
			puts "THIS IS NEW HOST NAME"
			puts @host.name

		end

		if !@event.hosts.pluck(:hostid).include?(@host.hostid)
			@event.save 
			@host.save
			@subscription = @event.subscriptions.new(subscribable: @host)
			@subscription.save
		end

		redirect_to events_path
	end



	def destroy
  		@event = Event.find(params[:id])
  		@event.destroy
  		redirect_to events_path
	end

end
