module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :host_check_in, mutation: Mutations::HostCheckIn
    field :self_check_in, mutation: Mutations::SelfCheckIn
    field :qr_check_in, mutation: Mutations::QrCheckIn
    field :delete_event, mutation: Mutations::DeleteEvent
    field :open_event, mutation: Mutations::OpenEvent
    field :close_event, mutation: Mutations::CloseEvent
  end
end
