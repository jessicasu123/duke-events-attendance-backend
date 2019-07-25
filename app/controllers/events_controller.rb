class EventsController < ApplicationController
	def index 
	@filterrific = initialize_filterrific(
	      Event,
	      params[:filterrific],
	      persistence_id: "shared_key",
	      default_filter_params: {},
	      available_filters: [:search_query, :with_eventid, :with_title],
	      sanitize_params: true,
    ) || return
		@events = @filterrific.find.page(params[:page])

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

	def openEvent(checkintype)
		@event = Event.find(params[:id])
		@event.status = "active"
		@event.checkintype = checkintype
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
			@event.save
		else
			#throw error
		end

		if @host.blank?
			#check if host is valid
			@host = Host.create(:hostid => val["subscribable_id"])
		else
			#throw error
		end

		if !@event.hosts.pluck(:hostid).include?(@host.hostid) 
			subscription = @event.subscriptions.create(subscribable: @host)
		end

		redirect_to @event

	end



	def destroy
  		@event = Event.find(params[:id])
  		@event.destroy
  		redirect_to events_path
	end

	# private
	#   def event_params
	#     params.require(:event).permit(:title, :eventid, :subscribable_id)
	#   end
end
