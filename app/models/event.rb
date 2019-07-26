require 'csv'
class Event < ApplicationRecord
	# ASSOCIATIONS
	has_many :subscriptions, as: :subscriber
	has_many :attendees, through: :subscriptions, source: :subscribable,dependent: :destroy, source_type: 'Attendee'
	has_many :hosts, through: :subscriptions, source: :subscribable, dependent: :destroy, source_type: 'Host'
	validates :title, presence: true
	# SEARCHING METHODS
	 filterrific(
    	available_filters: [
	      	:search_query,
	      	:with_eventid,
	      	:with_title,
    	],
  	)

	 scope :search_query, ->(query){
	 	return nil  if query.blank?
	 	# condition query, parse into individual keywords
  		terms = query.downcase.split(/\s+/)
  		terms = terms.map { |e|
		    (e.tr("*", "%") + "%").gsub(/%+/, "%")
		}

		num_or_conds = 2
	  	where(
	    	terms.map { |_term|
	    	  "(LOWER(events.title) LIKE ? OR LOWER(events.eventid) LIKE ?)"
	    	}.join(" AND "),
	    	*terms.map { |e| [e] * num_or_conds }.flatten,
	  	)
	 }

	scope :with_eventid, ->(eventid) {
  		where(eventid: [*eventids])
	}	

	scope :with_title, ->(titles) {
	  where(title: [*titles])
	}

	#To EXCEL file
	def to_csv(options = {})
		desired_columns = ["Name", "DUID", "Check-in Time"]
      	CSV.generate(options) do |csv|
	        csv << desired_columns
	        #event = all.first
	        event = Event.all.find_by_eventid(eventid)
	        subscriptions = event.subscriptions
	        subscriptions.each do |subscription|
	      		checkInTime = ""
	      		duid = ""
	      		if subscription.subscribable_type == 'Attendee'
					checkInTime = subscription.created_at.strftime("%I:%M %p")
					duid = Attendee.find(subscription.subscribable_id).duid
					attendee_name = Idmws.getName(duid)
				end
	          	csv << [attendee_name, duid, checkInTime]
	        end
      end
    end
end
