Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  root 'home#welcome'

  post "/graphql", to: "graphql#execute"
  get 'events' => 'events#index'
  get 'attendees' => 'attendees#index'
  get 'hosts' => 'hosts#index'
  get '/hosts/:id', to: 'hosts#show', as: 'host'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # post 'host_checkin' => 'hosts#checkin',  as: :host_checkin
  # post 'attendee_checkin' => 'attendees#checkin', as: :attendee_checkin
  # post 'attendees' => 'attendees#getAttendees', as: :getAttendees
end
