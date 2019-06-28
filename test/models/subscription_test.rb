require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "checking attendee" do
	  attendee = Attendee.new(duid: "0000")
	  subscription1 = Subscription.new(subscribable: attendee)

	  host = Host.new(hostid: "1111")
	  subscription2 = Subscription.new(subscribable: host)
	  #checkin1 = CheckIn.new(checkinable: attendee)
	  #puts checkin1.checkedin_type.inspect
	  #puts attendee.inspect
	  assert_equal(subscription1.subscribable, attendee)	
	  assert_equal(subscription2.subscribable, host)
	  #assert_equal(true, true)  
  end

  test "belongs to an event" do
  	event = Event.new
  	subscription = Subscription.new(event: event)
  	assert_equal(subscription.event, event)
  end
end
