Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :events
  

  post 'host_checkin' => 'hosts#checkin',  as: :host_checkin
  post 'attendee_checkin' => 'attendees#checkin', as: :attendee_checkin
  post 'attendees' => 'attendees#getAttendees', as: :getAttendees

  get 'attendees' => 'attendees#index', as: :index
  get 'attendees/:id' => 'attendees#show', as: :attendeeP
end
