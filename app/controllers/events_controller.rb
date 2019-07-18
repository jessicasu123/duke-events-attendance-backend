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
		@event = Event.find_by_eventid(:eventid)
		@host = Host.find_by_hostid(:hostid)

			if @event.blank? #doesn't exist
				@event = Event.new(event_params)
				@event.save
				redirect_to @event
			else
				#throw error
			end

	end


	def destroy
  		@event = Event.find(params[:id])
  		@event.destroy
  		redirect_to events_path
	end

	private
	  def event_params
	    params.require(:event).permit(:title, :eventid, host_ids: [])
	  end
end
