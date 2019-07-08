class HostsController < ApplicationController
skip_before_action :verify_authenticity_token 


	def index 
		@hosts = Host.all 
	end 

	def show 
		@host = Host.find(params[:id])
	end
	
	def checkin
		#when host "checks in" to the event, that event is created and 
		#subscription to the event for the host is created

        if !params[:eventid].blank?
        	if !params[:hostid].blank?
				@event = Event.create(:eventid => params[:eventid])
				@host = Host.create(:hostid => params[:hostid])
				subscription = @event.subscriptions.create(subscribable: @host)
				render :status => "200", :json => {:message => "Success"}.to_json
			else
				render :status => "400", :json => {:message => "Invalid Host ID"}.to_json
			end
	    else
	    	render :status => "400", :json => {:message => "Invalid Event ID"}.to_json
	    end

	end

	def show
		@host = Host.find(params[:id])
	end

end
