require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "has many subscriptions" do
  	event = Event.new(eventid: "CAL-111")
  	subscription1 = event.subscriptions.new
  	subscription2 = event.subscriptions.new

  	assert_equal(event.subscriptions.length, 2)
  	assert_equal(event.subscriptions[0], subscription1)
  	assert_equal(event.subscriptions[1], subscription2)
  end

  test "has many attendees through subscriptions" do
  	event = Event.create
  	attendee1 = Attendee.create
  	subscription1 = event.subscriptions.create(subscribable: attendee1)

  	attendee2 = Attendee.create
  	subscription2 = event.subscriptions.create(subscribable: attendee2)

  	assert_equal(event.subscriptions.length,2)
  	assert_equal(event.attendees[0],attendee1)
  	assert_equal(event.attendees[1],attendee2)
  end

  test "has many hosts through subscriptions" do
  	event = Event.create
  	host1 = Host.create
  	subscription1 = event.subscriptions.create(subscribable: host1)

  	host2 = Host.create
  	subscription2 = event.subscriptions.create(subscribable: host2)

  	assert_equal(event.subscriptions.length,2)
  	assert_equal(event.hosts[0],host1)
  	assert_equal(event.hosts[1],host2)
  end

end
