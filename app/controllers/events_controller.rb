class EventsController < ApplicationController
	def index 
		@events = Event.all 
	end 

	def show 
		@event = Event.find(params[:id])
	end

	def new 
		@event = Event.new 
	end


	def destroy
  		@event = Event.find(params[:id])
  		@event.destroy
  
	end
end
