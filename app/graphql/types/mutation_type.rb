module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :host_check_in, mutation: Mutations::HostCheckIn
    field :attendee_check_in, mutation: Mutations::AttendeeCheckIn
  end
end
