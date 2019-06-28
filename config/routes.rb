Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'host_checkin' => 'hosts#checkin',  as: :host_checkin
  post 'attendee_checkin' => 'attendees#checkin', as: :attendee_checkin
end
