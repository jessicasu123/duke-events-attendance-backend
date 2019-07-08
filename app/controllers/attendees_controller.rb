class AttendeesController < ApplicationController
	skip_before_action :verify_authenticity_token 
	
	def index 
		@attendees = Attendee.all 
	end 

	def show 
		@attendee = Attendee.find(params[:id])
	end

	def new 
		@attendee = Attendee.new 
	end

	def getAttendees
		@event = Event.find_by_eventid(params[:eventid])
		if !@event.blank?
			@attendees = @event.attendees
			render json: @attendees
		else 
			render :status => "400", :json => {:status => "Invalid Event ID"}.to_json
		end
	end

	def checkin
		#when attendee "checks in" to the event, attendee is validated through
		#transact and added to that event's subscription
		xml = createDukeCardXML(params[:duid])
		@event = Event.find_by_eventid(params[:eventid])
		
        if !@event.blank?
        	if !params[:duid].blank?
				if Transact.verify(xml) == "0" 
					@attendee = Attendee.create(:duid => params[:duid])
					subscription = @event.subscriptions.create(subscribable: @attendee)
					render :status => "200", :json => {:message => "Success"}.to_json
				else
					#render json: Transact.verify(xml)
					render :status => "400", :json => {:status => "Unauthorized User"}.to_json
				end
			else
				render :status => "400", :json => {:status => "Invalid DUID"}.to_json
			end

		else
			#if the event is not in the database, the event does not exist
			render :status => "400", :json => {:status => "Invalid Event ID"}.to_json
		end

	end

	private
	def createDukeCardXML(dukecard_number)
    	# file = File.open('example.xml')
    	# doc = Nokogiri::XML(file)
    	# element = doc.at('//card_number')
    	# element.content = dukecard_number
    	# puts doc
    	# doc

    	xml = "<transaction>
    		<command_type>4</command_type>
    		<register_number>24810</register_number>
    		<card_info>
    		<card_number>#{dukecard_number}</card_number>
    		<expr_date>1001</expr_date><pin />
    		</card_info><amount>0</amount><tender_info>
    		<tender_key>STATUS</tender_key>
    		<tender_deposit_key>01</tender_deposit_key>
    		</tender_info>
    	</transaction>"
    	xml
    end
end
