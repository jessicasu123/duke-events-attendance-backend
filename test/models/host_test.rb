require 'test_helper'

class HostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # test "has many events" do
  # 	host = Host.create
  # 	event1 = Event.new(eventid: "1234")
  # 	puts event1.inspect
  # 	event2 = Event.new(eventid: "5678")
  # 	puts event2.inspect
  	
  # 	host.subscriptions.create(event: event1)
  # 	host.subscriptions.create(event: event2)
  # 	# puts host.subscriptions.inspect
  # 	# puts host.events.inspect
  # 	puts host.subscriptions.first.inspect
  # 	#assert_equal(host.events.length, 2)
  # 	#assert_equal(host.subscribers[0], nil)
  # 	#assert_equal(host.subscribers[0], event2)
  # end

   test "has many event subscribers" do
    host = Host.create
    event1 = Event.new(eventid: "1234")
    host.subscriptions.create(subscriber: event1)
    event2 = Event.new(eventid: "5678")
    host.subscriptions.create(subscriber: event2)

    puts host.events.inspect

    assert_equal(host.events.length, 2)
    assert_equal(host.events[0], event1)
    assert_equal(host.events[1], event2)
  end

end
