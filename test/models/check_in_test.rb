require 'test_helper'
#require "test/unit/assertions"

class CheckInTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "checking attendee" do
	  attendee = Attendee.new(duid: "0000")
	  checkin1 = CheckIn.new(checkinable: attendee)
	  #puts checkin1.checkedin_type.inspect
	  #puts attendee.inspect
	  assert_equal(checkin1.checkinable, attendee)	
	  #assert_equal(true, true)  
  end

  #assert(checkin1.checkedin_type, attendee)
end
